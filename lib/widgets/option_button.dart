import 'package:flutter/material.dart';

class OptionButton extends StatefulWidget {
  final Function onClick;
  final double size;
  final String label;

  OptionButton({this.onClick, this.size, this.label});

  @override
  State createState() {
    return _OptionButtonState();
  }
}

class _OptionButtonState extends State<OptionButton> {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: widget.size * 0.6,
            width: widget.size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.size / 2),
              border: Border.all(
                width: 2,
                color: Colors.black,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: pressed ? Color(0xffbfbcaa) : Color(0xffd4d0bd),
                borderRadius: BorderRadius.circular(widget.size / 2),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff7D333F),
                    spreadRadius: 2,
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            widget.label,
            style: TextStyle(fontFamily: 'Liberation Sans', fontSize: 12),
          ),
        ],
      ),
    );
  }
}
