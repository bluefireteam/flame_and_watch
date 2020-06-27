import 'package:flutter/material.dart';

class GameButton extends StatefulWidget {
  final Function onClick;
  final double size;

  GameButton({this.onClick, this.size});

  @override
  State createState() {
    return _GameButtonState();
  }
}

class _GameButtonState extends State<GameButton> {
  bool pressed = false;

  void handleTapDown(_) {
    setState(() => pressed = true);
  }

  void handleTapCancel() {
    setState(() => pressed = false);
  }

  void handleTapUp(_) {
    widget.onClick?.call();
    setState(() => pressed = false);
  }

  @override
  Widget build(BuildContext ctx) {
    return GestureDetector(
      onTapDown: handleTapDown,
      onTapCancel: handleTapCancel,
      onTapUp: handleTapUp,
      child: Container(
        height: widget.size,
        width: widget.size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.size / 2),
          border: Border.all(
            width: 11,
            color: Colors.black,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: pressed ? Color(0xff9f2427) : Color(0xffBE3639),
            borderRadius: BorderRadius.circular(widget.size / 2),
            boxShadow: [
              BoxShadow(
                color: Color(0xff7D333F),
                spreadRadius: 10,
                blurRadius: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
