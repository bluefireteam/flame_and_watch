import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  final bool on;
  final Function onChange;
  final String label;

  SwitchButton({this.on, this.onChange, this.label});

  @override
  State createState() {
    return _SwitchButtonState();
  }
}

class _SwitchButtonState extends State<SwitchButton> {
  bool _status = true;

  void handleChange(value) {
    setState(() => _status = value);
    widget.onChange();
  }

  @override
  void initState() {
    super.initState();
    _status = widget.on;
  }

  @override
  Widget build(_) {
    return Container(
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.label,
            style: TextStyle(fontFamily: 'Liberation Sans', fontSize: 12),
          ),
          Container(
            padding: EdgeInsets.only(top: 6),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1),
              ),
            ),
          ),
          Row(children: [
            Text('Off', style: TextStyle(fontFamily: 'Liberation Sans', fontSize: 12)),
            Switch(
              activeColor: Color(0xff8a3842),
              activeTrackColor: Color(0xff86898a),
              inactiveThumbColor: Color(0xff8a3842),
              value: _status,
              onChanged: handleChange,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            Text('On', style: TextStyle(fontFamily: 'Liberation Sans', fontSize: 12)),
          ]),
        ],
      ),
    );
  }
}
