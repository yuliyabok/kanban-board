import '../../../../core/network/api_client.dart';
import '../dto/board_column_dto.dart';

abstract interface class ColumnRemoteDataSource {
  Future<BoardColumnDto> create(BoardColumnDto column);

  Future<BoardColumnDto> update(BoardColumnDto column);

  Future<void> delete(String columnId);
}

final class ApiColumnRemoteDataSource implements ColumnRemoteDataSource {
  const ApiColumnRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<BoardColumnDto> create(BoardColumnDto column) async {
    final response = await _apiClient.postJson(
      '/columns',
      body: column.toJson(),
    );
    return BoardColumnDto.fromJson(response);
  }

  @override
  Future<void> delete(String columnId) {
    return _apiClient.delete('/columns/$columnId');
  }

  @override
  Future<BoardColumnDto> update(BoardColumnDto column) async {
    final response = await _apiClient.patchJson(
      '/columns/${column.id}',
      body: column.toJson(),
    );
    return BoardColumnDto.fromJson(response);
  }
}

final class LocalColumnRemoteDataSource implements ColumnRemoteDataSource {
  const LocalColumnRemoteDataSource();

  @override
  Future<BoardColumnDto> create(BoardColumnDto column) async => column;

  @override
  Future<void> delete(String columnId) async {}

  @override
  Future<BoardColumnDto> update(BoardColumnDto column) async => column;
}
