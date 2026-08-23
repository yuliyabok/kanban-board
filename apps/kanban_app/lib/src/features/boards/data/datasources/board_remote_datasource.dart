import '../../../../core/network/api_client.dart';
import '../../domain/entities/board_entity.dart';
import '../mappers/board_mapper.dart';

abstract interface class BoardRemoteDataSource {
  Future<BoardEntity> create(BoardEntity board);

  Future<BoardEntity> update(BoardEntity board);

  Future<void> delete(String boardId);
}

final class ApiBoardRemoteDataSource implements BoardRemoteDataSource {
  const ApiBoardRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<BoardEntity> create(BoardEntity board) async {
    final response = await _apiClient.postJson(
      '/boards',
      body: board.toApiJson(),
    );

    return boardFromApiJson(response);
  }

  @override
  Future<void> delete(String boardId) {
    return _apiClient.delete('/boards/$boardId');
  }

  @override
  Future<BoardEntity> update(BoardEntity board) async {
    final response = await _apiClient.patchJson(
      '/boards/${board.id}',
      body: board.toApiJson(),
    );

    return boardFromApiJson(response);
  }
}

final class LocalBoardRemoteDataSource implements BoardRemoteDataSource {
  const LocalBoardRemoteDataSource();

  @override
  Future<BoardEntity> create(BoardEntity board) async {
    return board.copyWith(isSynced: true);
  }

  @override
  Future<void> delete(String boardId) async {}

  @override
  Future<BoardEntity> update(BoardEntity board) async {
    return board.copyWith(isSynced: true);
  }
}
