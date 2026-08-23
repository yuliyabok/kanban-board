import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../dto/task_comment_dto.dart';

abstract interface class TaskCommentRemoteDataSource {
  Future<List<TaskCommentDto>> getComments(String taskId);

  Future<TaskCommentDto> create(TaskCommentDto comment);

  Future<TaskCommentDto> update(TaskCommentDto comment);

  Future<void> delete(String commentId);
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

  @override
  Future<TaskCommentDto> create(TaskCommentDto comment) async {
    final response = await _apiClient.postJson(
      ApiEndpoints.taskComments(comment.taskId),
      body: comment.toJson(),
    );
    return TaskCommentDto.fromJson(response);
  }

  @override
  Future<void> delete(String commentId) {
    return _apiClient.delete(ApiEndpoints.comment(commentId));
  }

  @override
  Future<TaskCommentDto> update(TaskCommentDto comment) async {
    final response = await _apiClient.patchJson(
      ApiEndpoints.comment(comment.id),
      body: comment.toJson(),
    );
    return TaskCommentDto.fromJson(response);
  }
}

final class MockTaskCommentRemoteDataSource
    implements TaskCommentRemoteDataSource {
  const MockTaskCommentRemoteDataSource();

  @override
  Future<List<TaskCommentDto>> getComments(String taskId) async => const [];

  @override
  Future<TaskCommentDto> create(TaskCommentDto comment) async => comment;

  @override
  Future<void> delete(String commentId) async {}

  @override
  Future<TaskCommentDto> update(TaskCommentDto comment) async => comment;
}
