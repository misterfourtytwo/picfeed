import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:picfeed/providers/post_provider.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PostProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 26,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: 32,
            // ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      'Reddit: ' +
                          (provider.redditApi.authorized
                              ? provider.redditApi.username
                              : ''),
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Colors.red[800],
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: GFButton(
                        fullWidthButton: true,
                        size: GFSize.LARGE,
                        text:
                            provider.redditApi.authorized ? 'Logout' : 'Login',
                        color: Colors.red[800],
                        onPressed: provider.redditApi.authorized
                            ? () async {
                                print('logout from reddit');
                                await provider.logoutReddit();
                                print(provider.authorized);
                              }
                            : () async {
                                print('login into reddit');
                                await provider.authReddit();
                                print(provider.authorized);
                              },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Text(
                      'Pixiv:',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: GFButton(
                        fullWidthButton: true,
                        text: 'Login/Logout',
                        size: GFSize.LARGE,
                        color: Colors.blue,
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
