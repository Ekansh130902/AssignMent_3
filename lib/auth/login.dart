import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:test3/auth/login_form.dart';
import 'package:test3/auth/signup.dart';
import 'package:test3/consts/styles/style.dart';
import 'package:test3/pages/chat.dart';
import 'package:test3/services/instances/auth_services.dart';
import 'package:test3/services/instances/firebase_messaging_services.dart';
import 'package:test3/services/instances/firestore_services.dart';
import 'package:test3/services/models/user_model.dart';
import 'package:test3/widgets/button.dart';
import 'package:test3/widgets/continue_button.dart';
import 'package:test3/widgets/customTextField.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  // for go to signup
  onClickHandler(){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignupForm())
    );
  }

  // Google Signin Authentication
  void googleHandleLogin() async{
    try{
      // get user credentials
      UserCredential userCredential = await AuthService().signInWithGoogle();

      // generate fcm token
      String? token = await FirebaseMessagingServices().initNotifications();

      // create user
      UserModel userModel = UserModel(
          uid: userCredential.user!.uid,
          firstName: userCredential.user?.displayName ?? "",
          lastName: userCredential.user?.displayName ?? "",
          usernameOrPhoneNumber: userCredential.user?.email ?? "",
          dob: "dob ",  // can only be accessed if user allow
          fcm_token: token ?? "",
      );

      // insert it into Firestore
      await FirestoreService().saveUser(userModel);

      // if user successfully logged in, go to ChatBot
      if(userCredential != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatBot()));
      }
      else{ // else show error
        print("Error in google signin");
      }
    }
    catch(e){
        print("Error in google signin $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(signIn,style: TextStyle(fontSize: appBarTextSize, fontWeight: appBarFontWeight),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appBarColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: W,
          height: H,
          child: Column(
            children: [
              SizedBox(height: 20,),
              Container(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    // login form
                    LoginForm(),
                    // SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ", style: TextStyle(fontSize: 10),),
                        GestureDetector(
                          onTap: onClickHandler,
                          child: Text('Signup',style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),),
                        )
                      ],
                    ),
                    SizedBox(height: 17,),
                    Text(useSocialMedia),
                    SizedBox(height: 17,),
                    ContinueButton(data: cntGoogle, func: googleHandleLogin, src: gLogo),
                    SizedBox(height: 16,),
                    ContinueButton(data: cntTwitter, func: (){}, src: xLogo),
                    SizedBox(height: 16,),
                    ContinueButton(data: cntFacebook, func: (){}, src: fLogo),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
