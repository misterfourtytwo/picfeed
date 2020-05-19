import 'package:flutter/foundation.dart';

import 'package:picfeed/models/post.dart';
import 'package:picfeed/services/reddit_api.dart';

class PostProvider extends ChangeNotifier {
  bool get authorized => redditApi.authorized;
  RedditApi redditApi;
  PostProvider() {
    redditApi = RedditApi();
  }
  List<Post> posts = [];
  int get length => posts.length;
  operator [](int index) => posts[index];
  bool get isNotEmpty => posts.isNotEmpty;

  Future<void> authReddit() async {
    await redditApi.login();
    if (authorized)
      posts = await redditApi.loadPosts(
        count: 20,
      );
    notifyListeners();
  }

  Future<void> loadUpdates() async {
    print(('#' * 80 + '\n') * 3);
    // if (authorized)
    final submissions = await redditApi.loadPosts(
      count: 20,
      after: posts.isNotEmpty ? posts.first.id : null,
      // before: posts.isNotEmpty ? posts.last.id : null,
    );
    print(submissions);
    posts.addAll(submissions);
    // posts.addAll(submissions);
    notifyListeners();
  }

  Future<void> loadOlder() async {
    print(('#' * 80 + '\n') * 3);
    // if (authorized)
    final submissions = await redditApi.loadPosts(
      count: 20,
      before: posts.isNotEmpty ? posts.last.id : null,
      // before: posts.isNotEmpty ? posts.last.id : null,
    );
    print(submissions);
    posts.addAll(submissions);
    // posts.addAll(submissions);
    notifyListeners();
  }

  Future<void> logoutReddit() async {
    await redditApi.logout();
    posts.clear();
    notifyListeners();
  }
}
