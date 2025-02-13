import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:test3/consts/functions/functions.dart';
import 'package:test3/consts/styles/style.dart';
import 'package:test3/pages/chat.dart';
import 'package:test3/pages/splash_screen.dart';
import 'package:test3/services/instances/auth_services.dart';
import 'package:test3/services/models/user_model.dart';
import 'package:test3/widgets/button.dart';
import 'package:test3/widgets/customTextField.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  onClickHandler() async{


    throw Exception("This is a test crash!");
    //
    //
    // final isvalid = _formKey.currentState!.validate();
    // if (isvalid) {
    //   _formKey.currentState!.save();
    //
    //   // Form is valid, now check authentication
    //   try{
    //     // if user is valid, move it to ChatBot
    //     UserModel? user = await AuthService().login(email!, password!);
    //     if(user != null){
    //       Navigator.pushReplacement(
    //           context,
    //           MaterialPageRoute(builder: (context) => ChatBot())
    //       );
    //     }
    //   }
    //   catch(e){
    //     print("Error in login at login_form.dart");
    //   }
    // }
    // else {
    //   print('Error in Login in ');
    // }
  }

  onSavedHandler(String? value) {
    email = value?.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        margin: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                label: 'Email or Phone',
                hintText: 'Enter your Username',
                prefixIcon: Icons.person,
                validator: (value) => userNameValidator(value!.trim()),
                onSaved: (value) => onSavedHandler(value),
                onChanged: (value) {

                },
              ),
              SizedBox(height: 20),
              CustomTextField(
                label: 'Password',
                hintText: 'Password',
                prefixIcon: Icons.lock,
                isPassword: true,
                validator: (value) => checkPassword(value!),
                onSaved: (value) => password = value,
                onChanged: (value) {

                },
              ),
              Container(
                alignment: Alignment.centerRight,
                child: Text(
                  forgotPassword,
                  style: TextStyle(
                    color: forgotPasswordColour,
                    fontSize: forgotPasswordFontSize,
                  ),
                ),
              ),
              SizedBox(height: 50),
              Button(data: signIn, func: onClickHandler)
            ],
          ),
        ),
      ),
    );
  }
}
