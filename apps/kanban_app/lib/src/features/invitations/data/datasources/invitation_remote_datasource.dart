import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../dto/invitation_dto.dart';

abstract interface class InvitationRemoteDataSource {
  Future<List<InvitationDto>> getPending();
}

final class ApiInvitationRemoteDataSource
    implements InvitationRemoteDataSource {
  const ApiInvitationRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<InvitationDto>> getPending() async {
    final response = await _apiClient.getJson(ApiEndpoints.pendingInvitations);
    final items = response['invitations'] as List<dynamic>? ?? const [];
    return items
        .map((item) => InvitationDto.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }
}

final class MockInvitationRemoteDataSource
    implements InvitationRemoteDataSource {
  const MockInvitationRemoteDataSource();

  @override
  Future<List<InvitationDto>> getPending() async => const [];
}
