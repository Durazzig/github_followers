import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_followers/features/search/data/user_repository_impl.dart';
import 'package:github_followers/features/search/domain/user_model.dart';
import 'package:github_followers/features/search/domain/user_repository.dart';
import 'package:github_followers/managers/network_manager.dart';
import 'package:multiple_result/multiple_result.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl();
});

final userProvider = FutureProvider.autoDispose
    .family<Result<User, GFError>, String>((ref, username) async {
  final userRepository = ref.read(userRepositoryProvider);
  return userRepository.getUser(username: username);
});

final currentUsernameProvider = StateProvider<String>((ref) => "SAllen0400");

final currentUserProvider = StateProvider<User?>((ref) => null);

final errorProvider = StateProvider<GFError?>((ref) => null);
