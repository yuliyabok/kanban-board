import '../../../../core/error/result.dart';
import '../entities/invitation_entity.dart';
import '../repositories/invitation_repository.dart';

final class CreateInvitationUseCase {
  const CreateInvitationUseCase(this._repository);

  final InvitationRepository _repository;

  Future<Result<InvitationEntity>> call(InvitationEntity invitation) =>
      _repository.create(invitation);
}

final class AcceptInvitationUseCase {
  const AcceptInvitationUseCase(this._repository);

  final InvitationRepository _repository;

  Future<Result<InvitationEntity>> call({
    required String token,
    required String userId,
  }) => _repository.accept(token: token, userId: userId);
}

final class DeclineInvitationUseCase {
  const DeclineInvitationUseCase(this._repository);

  final InvitationRepository _repository;

  Future<Result<InvitationEntity>> call(String token) =>
      _repository.decline(token);
}

final class GetPendingInvitationsUseCase {
  const GetPendingInvitationsUseCase(this._repository);

  final InvitationRepository _repository;

  Future<Result<List<InvitationEntity>>> call(String email) =>
      _repository.getPending(email);
}
