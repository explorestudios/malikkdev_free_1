import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:simple_app/screen/screens.dart';
import 'configuration.dart';
import 'connection_bloc/connection_bloc.dart';

void main() {
  return runApp(SimpleApp());
}

class SimpleApp extends StatefulWidget {
  SimpleApp({Key key}) : super(key: key);

  @override
  _SimpleAppState createState() => _SimpleAppState();
}

class _SimpleAppState extends State<SimpleApp> {
  final Configuration config = Configuration();
  StreamSubscription _connectionSubscription;
  ConnectionBloc _connectionBloc;

  @override
  void initState() {
    super.initState();
    _connectionBloc = ConnectionBloc();
    checkInternet();
    _connectionSubscription =
        DataConnectionChecker().onStatusChange.listen((status) {
      print("Connection: $status");
      if (status == DataConnectionStatus.disconnected) {
        _connectionBloc.dispatch(MConnectionEvent.SetDisconnected);
      }
    });
  }

  checkInternet() async {
    if (await DataConnectionChecker().hasConnection == false) {
      _connectionBloc.dispatch(MConnectionEvent.SetDisconnected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConnectionBloc>(
      builder: (BuildContext context) => _connectionBloc,
      child: MaterialApp(
        title: config.appName,
        theme: ThemeData(primarySwatch: config.primarySwatch),
        home: Home(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _connectionSubscription.cancel();
    _connectionBloc.dispose();
  }
}
