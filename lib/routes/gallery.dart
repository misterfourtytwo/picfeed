import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:picfeed/providers/post_provider.dart';
import 'package:picfeed/widgets/item_preview.dart';
import 'package:provider/provider.dart';

class GalleryScreen extends StatefulWidget {
  GalleryScreen({Key key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.verified_user,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/auth');
            }),
      ),
      body: SafeArea(
          // child:
          //  GestureDetector(
          //     onHorizontalDragEnd: (details) =>
          //         // print(details.velocity.pixelsPerSecond.dx),
          //         details.primaryVelocity > 500
          //             ? Navigator.of(context).pushNamed('/auth')
          //             : null,
          child: Consumer<PostProvider>(
              builder: (context, p, _) => p.authorized
                  ? Column(
                      children: [
                        GFButton(
                          onPressed: () {
                            p.loadUpdates();
                          },
                          fullWidthButton: true,
                          text: 'Update',
                          color: Colors.red,
                        ),
                        if (p.isNotEmpty)
                          Expanded(
                            child: Container(
                              child: GridView.builder(
                                itemCount: p.length,
                                // padding: EdgeInsets.all(8),
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  // mainAxisSpacing: 3,
                                  maxCrossAxisExtent: 140,
                                  childAspectRatio: 1,
                                  // crossAxisSpacing: 4,
                                ),
                                itemBuilder: (context, index) => Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.blueGrey[800])),
                                  child: ItemPreviewWidget(
                                    index: index,
                                    post: p[index],
                                  ),
                                ),
                              ),
                            ),
                          )
                      ],
                    )
                  : Center(
                      child: Text(
                        'Please login in reddit',
                        style: Theme.of(context).textTheme.headline4.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ))),
      // ),
    );
  }
}
