import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class Configuration {
  // !WARNING
  bool connected = false;


  // TODO App Configure.
  final String appName = "Malikk Dev";
  final String appID = "com.example.myapp";
  final Color primarySwatch = Colors.blue;

  /// TODO Home Config
  final String appBarTitle = "Home";
  final String appBarImg = null;
  final bool centerTitle = false;
  final List<MButton> actionButtons = [
    MButton(url: "https://google.com", materialIcon: Icons.language),
    MButton(url: "https://youtube.com", materialIcon: Icons.video_library)
  ];
  final String mainUrl = "https://news.google.com/?hl=en-IN&gl=IN&ceid=IN:en";
  final String noConnectionImg = 'assets/no_connection.png';

  /// TODO Drawer Configuration
  final String shareUrl = "https://google.com";
  final String drawerHeaderName = "Malikk Dev";
  final String drawerHeaderEmail = "sameermalikk.dev@gmail.com";
  final String drawerHeaderImg = "assets/ic_launcher.png";

  // Gradient
  final List<Color> gradientColors = [Colors.blue, Colors.lightBlue];

  final bool drawerItemNavIcon = true;
  final List<DrawerItem> drawerItems = [
    DrawerItem(
        name: "Trending",
        url: "https://example.com",
        materialIcon: Icons.trending_up),
    DrawerItem(
        name: "Explore",
        url: "https://example.com",
        materialIcon: Icons.explore),
    DrawerItem(
        name: "Category",
        url: "https://example.com",
        materialIcon: Icons.category),
  ];

  /// TODO About Page
  final String aboutIconPath = null;
  final String appIconPath = "assets/explore.png";
  final String about =
      "nisi ut aliquip ex ea commodo consequat. Duis aute irure "
      "dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat "
      "nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in"
      " culpa qui officia deserunt mollit anim id est laborum.";
  final double version = 1.0;
  final String privacyPolicyUrl = "https://example.com";
}

// !WARNING
class MButton {
  final String url;
  final IconData materialIcon;
  final String img;

  MButton({@required this.url, this.materialIcon, this.img});
}

// !WARNING
class DrawerItem {
  final String name;
  final String url;
  final IconData materialIcon;
  final String imgPath;

  DrawerItem(
      {@required this.url,
      @required this.name,
      this.imgPath,
      this.materialIcon});
}

// !WARNING
Future<void> goPush(BuildContext context, {@required Widget widget}) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => widget));
}
