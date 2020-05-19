import 'package:flutter/material.dart';
import 'package:picfeed/models/post.dart';
import 'package:picfeed/providers/post_provider.dart';
import 'package:picfeed/routes/auth.dart';
import 'package:picfeed/routes/gallery.dart';
import 'package:picfeed/routes/post.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PostProvider>(
      create: (ctx) => PostProvider(),
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.grey[900],
          // backgroundColor: Colors.black
          // accentColor: Colors.teal,
          // highlightColor: Colors.green,
        ),
        title: 'picfeed',
        initialRoute: '/gallery',
        routes: {
          '/auth': (context) => AuthScreen(),
          '/gallery': (context) {
            // var a = ModalRoute.of(context).settings.arguments;
            // if (a is Map<String, String>) {
            return GalleryScreen();
          },
          '/post': (context) {
            Post post = ModalRoute.of(context).settings.arguments;
            return PostScreen(post: post);
          }
        },
      ),
    );
  }
}
