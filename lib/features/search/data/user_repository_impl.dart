import 'package:github_followers/core/constants/api_constants.dart';
import 'package:github_followers/features/search/domain/followers_response.dart';
import 'package:github_followers/features/search/domain/user_model.dart';
import 'package:github_followers/features/search/domain/user_repository.dart';
import 'package:github_followers/managers/network_manager.dart';
import 'package:multiple_result/src/result.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<Result<User, GFError>> getUser({required String username}) async {
    final request = Request(
      url: ApiConstants.getUser(username: username),
      method: RequestType.get,
    );

    final response = await NetworkManager.call<User>(
        request: request, fromJson: (json) => User.fromJson(json));

    return response;
  }

  @override
  Future<Result<FollowersResponse, GFError>> getFollowers(
      {required String username, required int page}) async {
    final request = Request(
      url: ApiConstants.getFollowers(username: username, page: page),
      method: RequestType.get,
    );

    final response = await NetworkManager.call<FollowersResponse>(
        request: request,
        parseToListObject: true,
        fromJson: (json) {
          return FollowersResponse.fromJson(json);
        });

    return response;
  }
}
