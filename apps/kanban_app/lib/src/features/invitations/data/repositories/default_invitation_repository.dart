import '../../../../core/database/app_database.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/sync/realtime_service.dart';
import '../../../permissions/domain/entities/permission.dart';
import '../../domain/entities/invitation_entity.dart';
import '../../domain/repositories/invitation_repository.dart';
import '../datasources/invitation_local_datasource.dart';
import '../mappers/invitation_mapper.dart';

final class DefaultInvitationRepository implements InvitationRepository {
  const DefaultInvitationRepository({
    required AppDatabase database,
    required InvitationLocalDataSource localDataSource,
    required RealtimeService realtimeService,
  }) : _database = database,
       _localDataSource = localDataSource,
       _realtimeService = realtimeService;

  final AppDatabase _database;
  final InvitationLocalDataSource _localDataSource;
  final RealtimeService _realtimeService;

  @override
  Stream<List<InvitationEntity>> watchPending(String email) {
    return _localDataSource
        .watchPending(email)
        .map(
          (rows) => rows.map((row) => row.toEntity()).toList(growable: false),
        );
  }

  @override
  Future<Result<InvitationEntity>> accept({
    required String token,
    required String userId,
  }) async {
    try {
      final row = await _localDataSource.getByToken(token);
      if (row == null) {
        return const Error(ValidationFailure('Приглашение не найдено'));
      }
      if (row.acceptedAt != null || row.declinedAt != null) {
        return const Error(ValidationFailure('Приглашение уже обработано'));
      }
      if (row.expiresAt.isBefore(DateTime.now().toUtc())) {
        return const Error(ValidationFailure('Приглашение истекло'));
      }
      final now = DateTime.now().toUtc();
      if (row.workspaceId != null) {
        await _database
            .into(_database.workspaceMembersTable)
            .insertOnConflictUpdate(
              WorkspaceMembersTableCompanion.insert(
                id: '${row.workspaceId}:$userId',
                workspaceId: row.workspaceId!,
                userId: userId,
                role: row.role,
                joinedAt: now,
              ),
            );
      }
      if (row.boardId != null) {
        await _database
            .into(_database.boardMembersTable)
            .insertOnConflictUpdate(
              BoardMembersTableCompanion.insert(
                id: '${row.boardId}:$userId',
                boardId: row.boardId!,
                userId: userId,
                role: row.role,
                joinedAt: now,
              ),
            );
      }
      final accepted = row.toEntity().copyWith(acceptedAt: now);
      await _localDataSource.upsert(accepted.toCompanion(syncAction: 'update'));
      _realtimeService.publish(
        RealtimeEvent(
          type: RealtimeEvents.invitationAccepted,
          payload: {'invitationId': accepted.id},
          occurredAt: now,
        ),
      );
      return Success(accepted);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<InvitationEntity>> create(InvitationEntity invitation) async {
    final validation = _validate(invitation);
    if (validation != null) return Error(validation);
    try {
      final existing = await _localDataSource.getAll();
      final hasDuplicate = existing.any(
        (row) =>
            row.email == invitation.email.trim().toLowerCase() &&
            row.workspaceId == invitation.workspaceId &&
            row.boardId == invitation.boardId &&
            row.acceptedAt == null &&
            row.declinedAt == null &&
            row.expiresAt.isAfter(DateTime.now().toUtc()),
      );
      if (hasDuplicate) {
        return const Error(ValidationFailure('Пользователь уже приглашен'));
      }
      final normalized = invitation.copyWith(
        email: invitation.email.trim().toLowerCase(),
      );
      await _localDataSource.upsert(
        normalized.toCompanion(syncAction: 'create'),
      );
      _realtimeService.publish(
        RealtimeEvent(
          type: RealtimeEvents.invitationCreated,
          payload: {'invitationId': normalized.id},
          occurredAt: DateTime.now().toUtc(),
        ),
      );
      return Success(normalized);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<InvitationEntity>> decline(String token) async {
    try {
      final row = await _localDataSource.getByToken(token);
      if (row == null) {
        return const Error(ValidationFailure('Приглашение не найдено'));
      }
      final declined = row.toEntity().copyWith(
        declinedAt: DateTime.now().toUtc(),
      );
      await _localDataSource.upsert(declined.toCompanion(syncAction: 'update'));
      return Success(declined);
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  @override
  Future<Result<List<InvitationEntity>>> getPending(String email) async {
    try {
      final rows = await _localDataSource.getPending(email);
      return Success(rows.map((row) => row.toEntity()).toList(growable: false));
    } on Exception catch (error) {
      return Error(StorageFailure(error.toString()));
    }
  }

  Failure? _validate(InvitationEntity invitation) {
    final email = invitation.email.trim();
    if (!email.contains('@') || !email.contains('.')) {
      return const ValidationFailure('Некорректный email');
    }
    if (invitation.workspaceId == null && invitation.boardId == null) {
      return const ValidationFailure('Нужен workspace или board');
    }
    if (invitation.workspaceId != null) {
      WorkspaceRole.parse(invitation.role);
    }
    if (invitation.boardId != null) {
      BoardRole.parse(invitation.role);
    }
    return null;
  }
}
