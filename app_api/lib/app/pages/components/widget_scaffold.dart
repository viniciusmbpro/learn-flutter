import 'package:flutter/material.dart';

WidgetScaffold(Widget base, String text) {
  return Scaffold(
    appBar: AppBar(
      title: Text(text),
      backgroundColor: Colors.greenAccent,
    ),
    body: Container(
      color: Colors.white,
      child: base,
    ),
  );
}
