class ApiConstants {
  static String getUser({required String username}) {
    return "https://api.github.com/users/$username";
  }

  static String getFollowers({required String username, required int page}) {
    return "https://api.github.com/users/$username/followers?per_page=100&page=$page";
  }
}
