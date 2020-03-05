import 'package:flutter/material.dart';
import 'curved_painter.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 300.0,
      ),
      painter: CurvedPainter(),
    );
  }
}