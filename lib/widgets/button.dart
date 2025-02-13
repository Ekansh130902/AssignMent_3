import 'package:flutter/material.dart';
import 'package:test3/consts/styles/style.dart';

class Button extends StatefulWidget {
  final String data;
  final Function func;
  String? src;
  Button({super.key, required this.data, required this.func, this.src});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: button_width,
      height: button_height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              gcolor1,
              gcolor2,
              gcolor3,
              gcolor4
            ]
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
          onPressed: (){
            widget.func();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent
          ),
          child: Text(
              '${widget.data}',
              style: TextStyle(color: button_color, fontWeight: button_fontWeight, fontSize: button_fontSize)
          )
      ),
    );
  }
}


