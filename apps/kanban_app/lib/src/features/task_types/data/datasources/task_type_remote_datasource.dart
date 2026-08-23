import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../dto/task_type_dto.dart';

abstract interface class TaskTypeRemoteDataSource {
  Future<TaskTypeDto> create(TaskTypeDto type);

  Future<TaskTypeDto> update(TaskTypeDto type);

  Future<void> delete(String id);
}

final class ApiTaskTypeRemoteDataSource implements TaskTypeRemoteDataSource {
  const ApiTaskTypeRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<TaskTypeDto> create(TaskTypeDto type) async {
    final response = await _apiClient.postJson(
      ApiEndpoints.taskTypes,
      body: type.toJson(),
    );
    return TaskTypeDto.fromJson(response);
  }

  @override
  Future<void> delete(String id) {
    return _apiClient.delete(ApiEndpoints.taskType(id));
  }

  @override
  Future<TaskTypeDto> update(TaskTypeDto type) async {
    final response = await _apiClient.patchJson(
      ApiEndpoints.taskType(type.id),
      body: type.toJson(),
    );
    return TaskTypeDto.fromJson(response);
  }
}

final class LocalTaskTypeRemoteDataSource implements TaskTypeRemoteDataSource {
  const LocalTaskTypeRemoteDataSource();

  @override
  Future<TaskTypeDto> create(TaskTypeDto type) async => type;

  @override
  Future<void> delete(String id) async {}

  @override
  Future<TaskTypeDto> update(TaskTypeDto type) async => type;
}
