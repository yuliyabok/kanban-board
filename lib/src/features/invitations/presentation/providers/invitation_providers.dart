import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/providers/core_providers.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';
import '../../data/datasources/invitation_local_datasource.dart';
import '../../data/repositories/default_invitation_repository.dart';
import '../../domain/entities/invitation_entity.dart';
import '../../domain/repositories/invitation_repository.dart';
import '../../domain/usecases/invitation_usecases.dart';

final invitationLocalDataSourceProvider = Provider<InvitationLocalDataSource>(
  (ref) => DriftInvitationLocalDataSource(ref.watch(appDatabaseProvider)),
);

final invitationRepositoryProvider = Provider<InvitationRepository>(
  (ref) => DefaultInvitationRepository(
    database: ref.watch(appDatabaseProvider),
    localDataSource: ref.watch(invitationLocalDataSourceProvider),
    realtimeService: ref.watch(realtimeServiceProvider),
  ),
);

final createInvitationUseCaseProvider = Provider<CreateInvitationUseCase>(
  (ref) => CreateInvitationUseCase(ref.watch(invitationRepositoryProvider)),
);

final acceptInvitationUseCaseProvider = Provider<AcceptInvitationUseCase>(
  (ref) => AcceptInvitationUseCase(ref.watch(invitationRepositoryProvider)),
);

final declineInvitationUseCaseProvider = Provider<DeclineInvitationUseCase>(
  (ref) => DeclineInvitationUseCase(ref.watch(invitationRepositoryProvider)),
);

final invitationsProvider = StreamProvider.autoDispose<List<InvitationEntity>>((
  ref,
) {
  final session = ref
      .watch(authControllerProvider)
      .maybeWhen(data: (value) => value, orElse: () => null);
  if (session == null) return const Stream.empty();
  return ref.watch(invitationRepositoryProvider).watchPending(session.email);
});

String newInvitationToken() => const Uuid().v7();
