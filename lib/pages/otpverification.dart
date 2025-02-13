import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:test3/auth/login.dart';
import 'package:test3/consts/styles/style.dart';
import 'package:test3/widgets/button.dart';

class OtpPage extends StatefulWidget {
  final String? email;
  const OtpPage({super.key, required this.email});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String finalCode="";

  @override
  Widget build(BuildContext context) {

    // submitting OTP
    void onSubmitHandler(){
      print(finalCode);
      if(finalCode.length < 5) return;

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login())
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(verification),
          scrolledUnderElevation: 0,
          centerTitle: true,
          elevation: 0,
          backgroundColor: appBarColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: H,
            width: W,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 75,),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: otpscreenSize,
                        height: otpscreenSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.blue.shade50,
                        ),
                      ),
                      Container(
                        width: 92,
                        height: 92,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.blue.shade300,
                        ),
                        child: Icon(Icons.lock, color: Colors.white, size: 36,),
                      ),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Text(verificationCode,style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  SizedBox(height: 10,),
                  Text(sentCodeText,style: TextStyle(color: Color(0xffDBDBDB), fontSize: 12)),
                  Text('${widget.email}', style: TextStyle(color: Colors.black),),
                  SizedBox(height: 60,),
                  OtpTextField(
                    numberOfFields: 5,
                    decoration: InputDecoration(),
                    borderColor: Color(0xFF512DA8),
                    showFieldAsBox: true,
                    onCodeChanged: (String code) {
                    },
                    onSubmit: (String verificationCode){
                      setState(() {
                        finalCode = verificationCode;
                      });
                      print(finalCode);
                    }, // end onSubmit
                  ),
                  SizedBox(height: 20,),
                  Button(data: submitText, func: onSubmitHandler)
                ],
              ),
            ),
          ),
        )
    );
  }
}


