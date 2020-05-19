import 'package:flutter/material.dart';
import 'package:getflutter/components/progress_bar/gf_progress_bar.dart';
import 'package:picfeed/models/post.dart';
import 'package:picfeed/providers/post_provider.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({this.post, Key key}) : super(key: key);
  final Post post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: GestureDetector(
            onTapDown: (details) {
              // bool next = details.localPosition.dx >
              //     MediaQuery.of(context).size.width / 2;
              // if (!next && post.id == 0) return;
              // Navigator.of(context).pushReplacementNamed('/post',
              //     arguments: Post(id: post.id + (next ? 1 : -1)));
            },
            child: Hero(
              tag: Provider.of<PostProvider>(context).posts.indexOf(post),
              child: Image.network(
                post.image,
                loadingBuilder: (context, child, chunk) {
                  if (chunk == null) return child;
                  return GFProgressBar(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    percentage: chunk?.cumulativeBytesLoaded != null &&
                            chunk.expectedTotalBytes != null
                        ? chunk.cumulativeBytesLoaded / chunk.expectedTotalBytes
                        : 0,
                    autoLive: false,
                  );
                },
                // cacheWidth: 420,
                filterQuality: FilterQuality.low,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
