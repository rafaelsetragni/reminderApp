import 'package:flutter/material.dart';

class NotificationSuccessPage extends StatefulWidget {
  NotificationSuccessPage({Key key}) : super(key: key);

  @override
  _NotificationSuccessPageState createState() =>
      _NotificationSuccessPageState();
}

class _NotificationSuccessPageState extends State<NotificationSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(" Notification Receidved"),
    );
  }
}
