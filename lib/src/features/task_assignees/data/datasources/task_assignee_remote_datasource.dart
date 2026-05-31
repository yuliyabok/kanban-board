import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../dto/task_assignee_dto.dart';

abstract interface class TaskAssigneeRemoteDataSource {
  Future<List<TaskAssigneeDto>> getAssignees(String taskId);
}

final class ApiTaskAssigneeRemoteDataSource
    implements TaskAssigneeRemoteDataSource {
  const ApiTaskAssigneeRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<TaskAssigneeDto>> getAssignees(String taskId) async {
    final response = await _apiClient.getJson(
      ApiEndpoints.taskAssignees(taskId),
    );
    final items = response['assignees'] as List<dynamic>? ?? const [];
    return items
        .map((item) => TaskAssigneeDto.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }
}

final class MockTaskAssigneeRemoteDataSource
    implements TaskAssigneeRemoteDataSource {
  const MockTaskAssigneeRemoteDataSource();

  @override
  Future<List<TaskAssigneeDto>> getAssignees(String taskId) async => const [];
}
