import 'dart:async';
import 'package:bloc/bloc.dart';

enum MConnectionState {
  Connected,
  Disconnected
}
enum MConnectionEvent {
  SetConnected,
  SetDisconnected
}

class ConnectionBloc extends Bloc<MConnectionEvent,MConnectionState>{

  @override
  MConnectionState get initialState => MConnectionState.Connected;

  @override
  Stream<MConnectionState> mapEventToState(MConnectionEvent event) async* {
    if(event == MConnectionEvent.SetConnected){
      yield MConnectionState.Connected;
    }else if(event == MConnectionEvent.SetDisconnected){
      yield MConnectionState.Disconnected;
    }
  }


}