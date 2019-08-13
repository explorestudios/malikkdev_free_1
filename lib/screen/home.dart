import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/connection_bloc/connection_bloc.dart';
import 'package:simple_app/widgets/connection_failed.dart';
import 'package:simple_app/widgets/drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../configuration.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  final Configuration config = Configuration();
  WebViewController _webController;
  bool _loaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: DrawerWidget(),
        appBar: AppBar(
          titleSpacing: 5,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              config.appBarImg == null
                  ? SizedBox()
                  : Image.asset(
                      config.appBarImg,
                      color: Colors.white,
                      width: 30,
                      height: 30,
                    ),
              config.appBarImg == null
                  ? SizedBox(
                      width: 5,
                    )
                  : SizedBox(width: 10),
              Text(config.appBarTitle)
            ],
          ),
          centerTitle: config.centerTitle,
          actions: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: config.actionButtons.map((button) {
                return IconButton(
                  icon: button.materialIcon != null
                      ? Icon(button.materialIcon)
                      : Image.asset(
                          button.img,
                          width: 25,
                          height: 25,
                        ),
                  onPressed: () => _webController.loadUrl(button.url),
                );
              }).toList(),
            )
          ],
          bottom: _loaded
              ? PreferredSize(child: SizedBox(), preferredSize: Size(0, 0))
              : PreferredSize(
                  child: LinearProgressIndicator(),
                  preferredSize: Size(MediaQuery.of(context).size.width, 3)),
        ),
        body: BlocBuilder(
          bloc: BlocProvider.of<ConnectionBloc>(context),
          builder: (BuildContext context, MConnectionState state) {
            if (state == MConnectionState.Connected) {
              return Builder(builder: (BuildContext context) {
                return WebView(
                  initialUrl: config.mainUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) => _webController = controller,
                  javascriptChannels: <JavascriptChannel>[
                    _toasterJavascriptChannel(context),
                  ].toSet(),
                  onPageFinished: (String url) {
                    setState(() {
                      this._loaded = true;
                    });
                    print('Page finished loading: $url');
                  },
                );
              });
            } else if (state == MConnectionState.Disconnected) {
              return buildNoConnection(context);
            }
            return null;
          },
        ));
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
//    _webController?.reload();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
//      _webController?.reload();
    }
  }
}
