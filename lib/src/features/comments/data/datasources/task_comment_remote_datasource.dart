import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../dto/task_comment_dto.dart';

abstract interface class TaskCommentRemoteDataSource {
  Future<List<TaskCommentDto>> getComments(String taskId);
}

final class ApiTaskCommentRemoteDataSource
    implements TaskCommentRemoteDataSource {
  const ApiTaskCommentRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<TaskCommentDto>> getComments(String taskId) async {
    final response = await _apiClient.getJson(
      ApiEndpoints.taskComments(taskId),
    );
    final items = response['comments'] as List<dynamic>? ?? const [];
    return items
        .map((item) => TaskCommentDto.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }
}

final class MockTaskCommentRemoteDataSource
    implements TaskCommentRemoteDataSource {
  const MockTaskCommentRemoteDataSource();

  @override
  Future<List<TaskCommentDto>> getComments(String taskId) async => const [];
}
