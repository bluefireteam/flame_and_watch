import 'package:flame_and_watch/widgets/console/console.dart';
import 'package:flutter/material.dart';

class FlameAndWatchScreen extends StatelessWidget {
  @override
  Widget build(_) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Console(),
        ),
      ),
    );
  }
}
