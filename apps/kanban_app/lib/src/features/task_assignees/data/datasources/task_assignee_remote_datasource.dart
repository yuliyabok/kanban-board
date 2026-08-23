import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../dto/task_assignee_dto.dart';

abstract interface class TaskAssigneeRemoteDataSource {
  Future<List<TaskAssigneeDto>> getAssignees(String taskId);

  Future<TaskAssigneeDto> assign(TaskAssigneeDto assignee);

  Future<void> unassign({
    required String taskId,
    required String userId,
  });
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

  @override
  Future<TaskAssigneeDto> assign(TaskAssigneeDto assignee) async {
    final response = await _apiClient.postJson(
      ApiEndpoints.taskAssignees(assignee.taskId),
      body: assignee.toJson(),
    );
    return TaskAssigneeDto.fromJson(response);
  }

  @override
  Future<void> unassign({
    required String taskId,
    required String userId,
  }) {
    return _apiClient.delete(ApiEndpoints.taskAssignee(taskId, userId));
  }
}

final class MockTaskAssigneeRemoteDataSource
    implements TaskAssigneeRemoteDataSource {
  const MockTaskAssigneeRemoteDataSource();

  @override
  Future<List<TaskAssigneeDto>> getAssignees(String taskId) async => const [];

  @override
  Future<TaskAssigneeDto> assign(TaskAssigneeDto assignee) async => assignee;

  @override
  Future<void> unassign({
    required String taskId,
    required String userId,
  }) async {}
}
