import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/connection_bloc/connection_bloc.dart';
import 'package:simple_app/widgets/connection_failed.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../configuration.dart';

class DrawerView extends StatefulWidget {
  final DrawerItem item;

  DrawerView(this.item, {Key key}) : super(key: key);

  @override
  _DrawerViewState createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> with WidgetsBindingObserver {
  WebViewController _controller;
  bool _loaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(widget.item.name),
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
                  initialUrl: widget.item.url,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller) => _controller = controller,
                  javascriptChannels: <JavascriptChannel>[
                    _toasterJavascriptChannel(context),
                  ].toSet(),
                  navigationDelegate: (NavigationRequest request) {
                    if (request.url.startsWith('https://www.youtube.com/')) {
                      print('blocking navigation to $request}');
                      return NavigationDecision.prevent;
                    }
                    print('allowing navigation to $request');
                    return NavigationDecision.navigate;
                  },
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
    _controller?.reload();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _controller?.reload();
    }
  }
}
