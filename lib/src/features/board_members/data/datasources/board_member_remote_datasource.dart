import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../dto/board_member_dto.dart';

abstract interface class BoardMemberRemoteDataSource {
  Future<List<BoardMemberDto>> getMembers(String boardId);
}

final class ApiBoardMemberRemoteDataSource
    implements BoardMemberRemoteDataSource {
  const ApiBoardMemberRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<List<BoardMemberDto>> getMembers(String boardId) async {
    final response = await _apiClient.getJson(
      ApiEndpoints.boardMembers(boardId),
    );
    final items = response['members'] as List<dynamic>? ?? const [];
    return items
        .map((item) => BoardMemberDto.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }
}

final class MockBoardMemberRemoteDataSource
    implements BoardMemberRemoteDataSource {
  const MockBoardMemberRemoteDataSource();

  @override
  Future<List<BoardMemberDto>> getMembers(String boardId) async => const [];
}
