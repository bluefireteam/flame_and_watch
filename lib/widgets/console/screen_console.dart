import 'package:flutter/material.dart';

class ScreenConsole extends StatelessWidget {
  final Widget child;

  ScreenConsole({this.child});

  @override
  Widget build(_) {
    return Expanded(
      flex: 6,
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xffc6cacb),
                border: Border(
                  top: BorderSide(width: 10, color: Color(0xFFb2b6b8)),
                  left: BorderSide(width: 10, color: Color(0xFFbabebf)),
                  right: BorderSide(width: 10, color: Color(0xFFbabebf)),
                  bottom: BorderSide(width: 10, color: Color(0xffa6a9ab)),
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(right: 8, left: 8, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffc6cacb),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color(0xff662a31),
                        width: 8,
                      ),
                    ),
                    child: child),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
