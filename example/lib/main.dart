import 'dart:async';

import 'package:flutter/material.dart';
import 'package:waiting_dialog/waiting_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _key = GlobalKey<NavigatorState>();

  Future _doLongProcess() async {
    //simulating
    await Future.delayed(Duration(seconds: 5));
  }

  void _onPressed() {
    showWaitingDialog(
        context: _key.currentState.overlay.context,
        onWaiting: () async => await _doLongProcess(),
        strokeWidth: 12.0,
        onDone: () {
          //your code after waiting
          print('is done!');
        });
  }

  Widget button([String caption]) {
    ThemeData theme = Theme.of(context);
    return RaisedButton(
      onPressed: _onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: theme.primaryColor,
      textColor: theme.dialogBackgroundColor,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Text('${caption ?? ""}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _key,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Waiting dialog example app'),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[button('One button'), button()],
          ),
        ),
      ),
    );
  }
}
