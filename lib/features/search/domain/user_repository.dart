import 'package:github_followers/features/search/domain/followers_response.dart';
import 'package:github_followers/features/search/domain/user_model.dart';
import 'package:github_followers/managers/network_manager.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class UserRepository {
  Future<Result<User, GFError>> getUser({required String username});
  Future<Result<FollowersResponse, GFError>> getFollowers(
      {required String username, required int page});
}
