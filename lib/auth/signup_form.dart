import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  String userName = '';
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();


  trysubmit() {
    final isvalid = _formKey.currentState!.validate();
    if (isvalid) {
      _formKey.currentState!.save();
      submitform();
    } else {
      print('Error');
    }
  }

  submitform() {   // DB Interaction
    print(userName);
    print(email);
    print(password);
  }

  bool isEmail(String input) => EmailValidator.validate(input);

  bool isPhone(String input) => RegExp(
      r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$'
  ).hasMatch(input);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        margin: EdgeInsets.all(10),
        // color: Colors.red,
        child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                decoration: InputDecoration(hintText: 'Enter your Username'),
                key: ValueKey('userName'),
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return 'Username should not be Empty';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  userName = value.toString();
                },
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Enter Email or Phone number'),
                key: ValueKey('email'),
                validator: (value) {
                  value = value.toString();
                  if (!isEmail(value) && !isPhone(value)) {
                    return 'Please enter a valid email or phone number.';
                  }
                  return null;
                },
                onSaved: (value) {
                  email = value.toString();
                },
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(hintText: 'Enter Password'),
                key: ValueKey('password'),
                validator: (value) {
                  value = value.toString();


                  return null;
                },
                onSaved: (value) {
                  password = value.toString();
                },
              ),
              // TextButton(
              //     onPressed: () {
              //       trysubmit();
              //     },
              //     child: Text('Submit')
              // )
              // Button(data: 'Create Account', func: )
            ])),
      ),
    );
  }
}


