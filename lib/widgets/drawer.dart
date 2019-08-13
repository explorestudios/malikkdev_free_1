import 'package:flutter/material.dart';
import 'package:share/share.dart' as Share;
import 'package:simple_app/screen/screens.dart';

import '../configuration.dart';

class DrawerWidget extends StatefulWidget {
  DrawerWidget({Key key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final Configuration config = Configuration();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(config.drawerHeaderName),
          accountEmail: Text(config.drawerHeaderEmail),
          otherAccountsPictures: <Widget>[
            CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      return Share.Share.share(config.shareUrl);
                    }))
          ],
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: config.gradientColors,
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight)),
        ),
        Column(
          children: config.drawerItems.map((item) {
            return Column(
              children: <Widget>[
                ListTile(
                  trailing: config.drawerItemNavIcon
                      ? Icon(Icons.arrow_forward)
                      : SizedBox(),
                  leading: item.materialIcon != null
                      ? Icon(item.materialIcon)
                      : Image.asset(
                    item.imgPath,
                    width: 25,
                    height: 25,
                  ),
                  title: Text(item.name),
                  onTap: () => goPush(context, widget: new DrawerView(item)),
                ),
                Divider(
                  height: 0,
                  indent: 10,
                  endIndent: 10,
                )
              ],
            );
          }).toList(),
        ),
        ListTile(
            title: Text("About"),
            leading: config.aboutIconPath != null
                ? Image.asset(
                    config.aboutIconPath,
                    width: 25,
                    height: 25,
                  )
                : Icon(Icons.info),
            onTap: () => goPush(
                  context,
                  widget: AboutScreen(),
                ))
      ],
    ));
  }
}
