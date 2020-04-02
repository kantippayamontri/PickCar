import 'package:flutter/material.dart';
import 'package:pickcar/bloc/serve/servebloc.dart';
import 'package:pickcar/datamanager.dart';

class ServerPage extends StatefulWidget {
  @override
  _ServerPageState createState() => _ServerPageState();
}

class _ServerPageState extends State<ServerPage> {
  ServeBloc _serveBloc;

  @override
  void initState() {
    // TODO: implement initState

    _serveBloc = ServeBloc(context: this.context);

    super.initState();
  }
  dispose() {
    Realtime.servertimer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _serveBloc.looptime();
    return Scaffold(
      body: Center(
        child: Center(
          child: Text("Serverpage"),
        ),
      ),
    );
  }
}
