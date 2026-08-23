import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../dto/user_dto.dart';

abstract interface class UserRemoteDataSource {
  Future<List<UserDto>> search(String query);

  Future<UserDto> getById(String id);

  Future<UserDto> updateMe(UserDto user);
}

final class ApiUserRemoteDataSource implements UserRemoteDataSource {
  const ApiUserRemoteDataSource(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<UserDto> getById(String id) async {
    return UserDto.fromJson(await _apiClient.getJson(ApiEndpoints.user(id)));
  }

  @override
  Future<List<UserDto>> search(String query) async {
    final response = await _apiClient.getJson(
      ApiEndpoints.usersSearch,
      queryParameters: {'query': query},
    );
    final users = response['users'] as List<dynamic>? ?? const [];
    return users
        .map((item) => UserDto.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }

  @override
  Future<UserDto> updateMe(UserDto user) async {
    return UserDto.fromJson(
      await _apiClient.patchJson(ApiEndpoints.userMe, body: user.toJson()),
    );
  }
}

final class MockUserRemoteDataSource implements UserRemoteDataSource {
  const MockUserRemoteDataSource();

  @override
  Future<UserDto> getById(String id) {
    throw UnimplementedError('Mock user lookup is local-only');
  }

  @override
  Future<List<UserDto>> search(String query) async => const [];

  @override
  Future<UserDto> updateMe(UserDto user) async => user;
}
