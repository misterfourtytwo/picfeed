import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:picfeed/models/post.dart';

class ItemPreviewWidget extends StatelessWidget {
  const ItemPreviewWidget({this.index, this.post, Key key}) : super(key: key);
  final Post post;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/post', arguments: post);
      },
      child: Hero(
        tag: index,
        child: Image.network(
          post.thumbnail,
          loadingBuilder: (context, child, chunk) {
            if (chunk == null) return child;
            return GFProgressBar(
              percentage: chunk?.cumulativeBytesLoaded != null &&
                      chunk.expectedTotalBytes != null
                  ? chunk.cumulativeBytesLoaded / chunk.expectedTotalBytes
                  : 0,
              autoLive: false,
            );
          },
          fit: BoxFit.cover,
          filterQuality: FilterQuality.low,
        ),
      ),
    );
  }
}
