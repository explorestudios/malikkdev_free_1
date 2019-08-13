import 'package:flutter/material.dart';
import 'package:simple_app/configuration.dart';

Widget buildNoConnection(BuildContext context) {
  final Configuration config = Configuration();
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Image(
          image: AssetImage(config.noConnectionImg),
        ),
        Text(
          "No Connection!",
          style: Theme.of(context).textTheme.headline,
        )
      ],
    ),
  );
}
