import '../../../../core/error/result.dart';
import '../entities/invitation_entity.dart';

abstract interface class InvitationRepository {
  Stream<List<InvitationEntity>> watchPending(String email);

  Future<Result<InvitationEntity>> create(InvitationEntity invitation);

  Future<Result<InvitationEntity>> accept({
    required String token,
    required String userId,
  });

  Future<Result<InvitationEntity>> decline(String token);

  Future<Result<List<InvitationEntity>>> getPending(String email);
}
