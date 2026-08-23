import '../../../../core/network/api_client.dart';
import '../dto/task_dto.dart';

abstract interface class TaskRemoteDataSource {
  Future<TaskDto> create(TaskDto task);

  Future<TaskDto> update(TaskDto task);

  Future<void> delete(String taskId);
}

final class ApiTaskRemoteDataSource implements TaskRemoteDataSource {
  const ApiTaskRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<TaskDto> create(TaskDto task) async {
    final response = await _apiClient.postJson('/tasks', body: task.toJson());
    return TaskDto.fromJson(response);
  }

  @override
  Future<TaskDto> update(TaskDto task) async {
    final response = await _apiClient.patchJson(
      '/tasks/${task.id}',
      body: task.toJson(),
    );
    return TaskDto.fromJson(response);
  }

  @override
  Future<void> delete(String taskId) {
    return _apiClient.delete('/tasks/$taskId');
  }
}

final class LocalTaskRemoteDataSource implements TaskRemoteDataSource {
  const LocalTaskRemoteDataSource();

  @override
  Future<TaskDto> create(TaskDto task) async {
    return task;
  }

  @override
  Future<void> delete(String taskId) async {}

  @override
  Future<TaskDto> update(TaskDto task) async {
    return task;
  }
}
