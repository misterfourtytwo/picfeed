import 'dart:async';
import 'dart:math';

import 'package:draw/draw.dart';
import 'package:picfeed/models/post.dart';
import 'package:picfeed/services/secret.dart';
// import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

final _authEndpoint = Uri.parse('https://oauth.reddit.com');
final _tokenEndpoint = Uri.parse('https://www.reddit.com');
final Uri _redirectUri = Uri.parse('com.misterfourtytwo.picfeed://reddit');

class RedditApi {
  Reddit reddit;
  Uri authUri;
  String username;
  bool get authorized => reddit.auth.credentials != null && reddit.auth.isValid;

  RedditApi() {
    reddit = Reddit.createInstalledFlowInstance(
      clientId: clientId,
      userAgent: userAgent,
      redirectUri: _redirectUri,
      tokenEndpoint: _tokenEndpoint,
      authEndpoint: _authEndpoint,
    );
  }

  Future<bool> login() async {
    // Present the dialog to the user

    authUri = reddit.auth.url(
        ['read', 'identity', 'history', 'mysubreddits', 'save'], 'picfeed');
    try {
      if (await canLaunch(authUri.toString())) {
        print(authUri.toString());
        await launch(
          authUri.toString(),
        );
      } else {
        print('Could not launch $authUri');
        return false;
      }

      Uri result =
          //  (await getInitialUri()) ??
          await getUriLinksStream()
              .where((uri) =>
                  uri != null &&
                  uri.toString().startsWith(_redirectUri.toString()))
              .first;
      // print('result: $result');
      String authCode = result.queryParameters['code'];
      print('authorization code: $authCode');
      // final result = await FlutterWebAuth.authenticate(
      //     url: authUri.toString(), callbackUrlScheme: _redirectUri.toString());
      // Extract token from resulting url
      await reddit.auth.authorize(authCode);
      // await loadPosts();
    } catch (e) {
      print(e);
      return false;
    }
    username = (await reddit.user.me()).displayName;
    print('heyya');
    return true;
  }

  logout() async {
    await reddit.auth.revoke();
  }

  Future<List<Post>> loadPosts(
      {int count: 10, String before, String after}) async {
    print('loading posts');
    List<Submission> submissions = [];
    await for (var value in reddit.front.best(limit: min(count, 100), params: {
      if (after != null) 'after': after,
      if (before != null) 'before': before
    })) {
      print(value.infoPath);
      print(value.infoParams);
      if (value is Submission) {
        if (!value.isSelf) continue;
        print('submission ' + '#' * 42);
        print('ID: ${value.id}');
        print(value.body);
        print('URL: ${value.url}');
        print('short: ${value.shortlink}');
        print('short: https://redd.it/' + value.id);
        print('#' * 42);
        String filepath = value.url.toString().split('/').last;
        if (filepath.endsWith('.jpg') ||
            filepath.endsWith('.png') ||
            filepath.endsWith('.gif')) {
          submissions.add(value);

          if (submissions.length > count) break;
        }
      }
    }

    return submissions
        .map((e) => Post(
              id: e.id,
              thumbnail: e.thumbnail.toString(),
              image: e.url.toString(),
              link: 'https://redd.it/' + e.id,
              title: e.selftext,
            ))
        .toList();
  }
}
