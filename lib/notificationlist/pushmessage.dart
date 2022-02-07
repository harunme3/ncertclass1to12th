import 'package:flutter/material.dart';

class PushMessagePage extends StatefulWidget {
  PushMessagePage();

  @override
  _PushMessagePageState createState() => _PushMessagePageState();
}

class _PushMessagePageState extends State<PushMessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification',
            style: Theme.of(context).primaryTextTheme.bodyText1),
      ),
      body: Center(
        child: Container(
          child: Text("Currently you don't have any Notification",
              style: Theme.of(context).primaryTextTheme.bodyText1),
        ),
      ),
    );
  }
}
