import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../dto/workspace_dto.dart';

abstract interface class WorkspaceRemoteDataSource {
  Future<List<WorkspaceDto>> getAll();

  Future<WorkspaceDto> create(WorkspaceDto workspace);

  Future<List<WorkspaceMemberDto>> getMembers(String workspaceId);
}

final class ApiWorkspaceRemoteDataSource implements WorkspaceRemoteDataSource {
  const ApiWorkspaceRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<WorkspaceDto> create(WorkspaceDto workspace) async {
    return WorkspaceDto.fromJson(
      await _apiClient.postJson(
        ApiEndpoints.workspaces,
        body: workspace.toJson(),
      ),
    );
  }

  @override
  Future<List<WorkspaceDto>> getAll() async {
    final response = await _apiClient.getJson(ApiEndpoints.workspaces);
    final items = response['workspaces'] as List<dynamic>? ?? const [];
    return items
        .map((item) => WorkspaceDto.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }

  @override
  Future<List<WorkspaceMemberDto>> getMembers(String workspaceId) async {
    final response = await _apiClient.getJson(
      ApiEndpoints.workspaceMembers(workspaceId),
    );
    final items = response['members'] as List<dynamic>? ?? const [];
    return items
        .map(
          (item) => WorkspaceMemberDto.fromJson(item as Map<String, dynamic>),
        )
        .toList(growable: false);
  }
}

final class MockWorkspaceRemoteDataSource implements WorkspaceRemoteDataSource {
  const MockWorkspaceRemoteDataSource();

  @override
  Future<WorkspaceDto> create(WorkspaceDto workspace) async => workspace;

  @override
  Future<List<WorkspaceDto>> getAll() async => const [];

  @override
  Future<List<WorkspaceMemberDto>> getMembers(String workspaceId) async =>
      const [];
}
