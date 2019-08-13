import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:simple_app/screen/screens.dart';

import '../configuration.dart';

class AboutScreen extends StatefulWidget {
  AboutScreen({Key key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final Configuration config = Configuration();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text("About"),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 15),
                  Image.asset(
                    config.appIconPath,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width / 3,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris '
                      'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
                  SizedBox(height: 5)
                ],
              ),
            ),
            Divider(
              height: 0,
            ),
            ListTile(
              title: Text("Privacy Policy"),
              onTap: () => goPush(context,
                  widget: DrawerView(
                    DrawerItem(
                        name: "Privacy Policy", url: config.privacyPolicyUrl),
                  )),
            ),
            Divider(
              height: 0,
            ),
            ListTile(
              title: Text("Version ${config.version}"),
            ),
            Divider(
              height: 0,
            ),
          ],
        ),
        bottomSheet: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: Theme.of(context).textTheme.caption,
                      children: [
                        TextSpan(text: "Created by "),
                        TextSpan(
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () async {
                                const url =
                                    'https://malikkdev.page.link/youtube';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                            text: "Explore Studios.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor))
                      ]),
                ),
              ),
            )
          ],
        ));
  }
}
