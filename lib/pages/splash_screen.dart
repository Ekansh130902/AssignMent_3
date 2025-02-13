import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test3/consts/styles/style.dart';
import 'package:test3/auth/login.dart';
import 'package:test3/auth/signup.dart';
import 'package:test3/widgets/button.dart';
import 'package:test3/widgets/octagonal_container.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void initState() {
    super.initState();
    Timer(Duration(seconds: splash_timer), () {
      // Navigate to the Login after 3 seconds
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipRect(
          child: OverflowBox(
              maxWidth: double.infinity,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: main_container_height,
                    width: main_container_width,
                    child: Stack(
                      children: [
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // used to create octagon container using clip path
                              OctagonalContainer(width: size_oct1, height: size_oct1, imageUrl: oct_url1),
                              OctagonalContainer(width: size_oct1, height: size_oct1, imageUrl:  oct_url2)
                            ],
                          ),
                        ),
                        Align(
                          child: OctagonalContainer(width: size_oct2, height: size_oct2, imageUrl: oct_url3),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(splash_mainHeading, style: TextStyle(fontWeight: mainHeading_fontWeight, fontSize: mainHeading_fontSize),),
                  Text(splash_subHeading),
                  SizedBox(height: 70,),
                ],
              )
          ),
        ),
      ),
    );
  }
}

