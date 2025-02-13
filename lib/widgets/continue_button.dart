import 'package:flutter/material.dart';
import 'package:test3/consts/styles/style.dart';

class ContinueButton extends StatefulWidget {
  final String data;
  final Function func;
  String src;
  ContinueButton({super.key, required this.data, required this.func, this.src=''});

  @override
  State<ContinueButton> createState() => _ContinueButtonState();
}

class _ContinueButtonState extends State<ContinueButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width:button_width,
      height:button_height,
      child: ElevatedButton(
          onPressed: (){
            widget.func();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: continue_button_color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(continue_button_radius),
            ),
          ),
          child: Container(

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // Logo
                Container(
                    child: Image(image: AssetImage(widget.src), fit: BoxFit.contain,width: logo_size,)
                ),
                SizedBox(
                  width: 16,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    width: 150,
                    child: Text('${widget.data}',style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14))
                )
              ],
            ),
          )
      ),
    );
  }
}


