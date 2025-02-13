import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:intl/intl.dart';
import 'package:test3/auth/login.dart';
import 'package:test3/consts/functions/functions.dart';
import 'package:test3/consts/styles/style.dart';
import 'package:test3/pages/otpverification.dart';
import 'package:test3/services/instances/auth_services.dart';
import 'package:test3/services/models/user_model.dart';
import 'package:test3/widgets/button.dart';
import 'package:test3/widgets/continue_button.dart';


class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  bool isHiddenPassword = true;
  bool isHiddenConfirmPassword = true;

  String firstName='', lastName='', userName='', password='', confirmPassword='';
  DateTime? selectedDOB;

  // Ensure the default value is 18
  int selectedAge = 18;

  // Function to pick a date
  Future<void> _selectDOB(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(Duration(days: 18 * 365)), // Default 18 years back
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDOB) {
      setState(() {
        selectedDOB = picked;
        int calculatedAge = DateTime.now().year - picked.year;

        // Ensure age is never less than 18
        if (calculatedAge < 18) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Age must be 18+")),
          );
          return;
        }
        selectedAge = calculatedAge;
      });
    }
  }

  bool isFirstNameEmpty = true;
  bool isLastNameEmpty = true;
  bool isUserNameEmpty = true;
  bool isCfmPassEmpty = true;
  bool isPassEmpty= true;

  onClickHandler(){
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login())
    );
  }


  @override
  Widget build(BuildContext context) {



    onSubmitHandler() async{
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        // Ensure age & DOB match
        int calculatedAge = DateTime.now().year - selectedDOB!.year;
        if (calculatedAge != selectedAge) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Age and Date of Birth don't match!")),
          );
          return;
        }

        // Form data is fine, now signup user
        String dob = 'DOB: ${DateFormat('dd/MM/yyyy').format(selectedDOB!)}';

        try{
          UserModel? user = await AuthService().signUp(firstName: firstName, lastName: lastName,
              usernameOrPhoneNumber: userName,
              password: password, dob: dob);

          // navigate to OtpPage if user exists
          if(user != null){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => OtpPage(email: userName))
            );
          }

        }
        catch(e){
          print("Error in Signup in signup.dart");
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(createAcc, style: TextStyle(fontSize: appBarTextSize, fontWeight: appBarFontWeight),),
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        width: W,
        height: H,
        child: Container(
          width: 300,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Container(alignment: Alignment.centerLeft, child: Text('First Name',
                    style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
                  )),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10),
                        ),

                        focusedBorder: InputBorder.none,
                        hintText: 'Enter your First Name',
                        hintStyle: TextStyle(color: iconColor),

                        prefixIcon: isFirstNameEmpty == false ?
                        Icon(Icons.person,color: Colors.blue,) :
                        Icon(Icons.person,color: iconColor,),
                        border: OutlineInputBorder(),
                        fillColor: fillColor,
                        filled: true,
                      ),
                      validator: (value) =>
                      value!.isEmpty ? 'Enter First Name' : null,
                      onSaved: (value){
                        firstName = value!;
                      },
                      onChanged: (value){
                        setState(() {
                          if(value.length > 0){
                            isFirstNameEmpty = false;
                          }
                          else{
                            isFirstNameEmpty = true;
                          }
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 20,),

                  Container(alignment: Alignment.centerLeft, child: Text('Last Name',
                    style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
                  )),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                          fillColor: fillColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: InputBorder.none,

                          hintText: 'Enter your Last Name',
                          hintStyle: TextStyle(color: iconColor),
                          prefixIcon: isLastNameEmpty == false ?
                          Icon(Icons.person,color: Colors.blue,) :
                          Icon(Icons.person,color: iconColor,),
                          suffixIconColor: Color(0xFFDBDBDB)
                      ),
                      validator: (value) => value!.isEmpty ? 'Enter Last Name' : null,
                      onSaved: (value) => lastName = value!,
                      onChanged: (value){
                        setState(() {
                          if(value.length > 0){
                            isLastNameEmpty = false;
                          }
                          else{
                            isLastNameEmpty = true;
                          }
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 16),

                  // Age Picker (Ensuring Age is 18+)
                  Text("Select Age: $selectedAge"),
                  NumberPicker(
                    axis: Axis.horizontal,
                    minValue: 18,
                    maxValue: 100,
                    value: selectedAge,
                    onChanged: (value) => setState(() => selectedAge = value),
                  ),

                  SizedBox(height: 16),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Date of Birth", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => _selectDOB(context),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            fillColor: Color(0xFFF8F8F8),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            suffixIcon: Icon(Icons.calendar_today, color: Colors.blueAccent),
                            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          ),
                          
                          child: selectedDOB == null ? Text('Select Date of Birth',style: TextStyle(color: iconColor, fontWeight: FontWeight.w500, fontSize: 15 ),)
                              : Text(DateFormat('dd/MM/yyyy').format(selectedDOB!))
                          ),
                        ),
                    ],
                  ),

                  SizedBox(height: 16,),

                  // Username
                  Container(alignment: Alignment.centerLeft, child: Text('Username',
                    style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
                  )),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      expands: false,
                      decoration: InputDecoration(
                        fillColor: fillColor,
                        filled: true,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: InputBorder.none,
                        hintText: 'Enter your Username',
                        hintStyle: TextStyle(color: iconColor),
                        prefixIcon: isUserNameEmpty == false ?
                        Icon(Icons.person,color: Colors.blue,) :
                        Icon(Icons.person,color: iconColor,),
                        border: OutlineInputBorder(),
                      ),
                      key: ValueKey('email'),
                      validator: (value) {
                        value = value.toString();
                        if (!isEmail(value) && !isPhone(value)) {
                          return 'Please enter a valid email or phone number.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        userName = value.toString();
                      },
                      onChanged: (value){
                        setState(() {
                          if(value.length > 0){
                            isUserNameEmpty = false;
                          }
                          else{
                            isUserNameEmpty = true;
                          }
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 16),

                  // Password Field
                  Container(alignment: Alignment.centerLeft, child: Text('Password',
                    style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
                  )),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      expands: false,
                      obscureText: isHiddenPassword,
                      onChanged: (value){
                        setState(() {
                          if(value.length > 0){
                            isPassEmpty = false;
                          }
                          else{
                            isPassEmpty = true;
                          }
                        });
                      },
                      decoration: InputDecoration(
                          fillColor: fillColor,
                          filled: true,
                          border: OutlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: TextStyle(color: iconColor),
                          prefixIcon: isPassEmpty == false ?
                          Icon(Icons.lock,color: Colors.blue,) :
                          Icon(Icons.lock,color: iconColor,),
                          suffixIcon: GestureDetector(
                              onTap: (){
                                setState(() {
                                  isHiddenPassword = !isHiddenPassword;
                                });
                              },
                              child: isHiddenPassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off)
                          ),
                          suffixIconColor: iconColor
                      ),
                      validator: (value) {
                        value = value.toString();
                        // check password validations
                        return checkPassword(value);
                      },
                      onSaved: (value) => password = value!,
                    ),

                  ),

                  SizedBox(height: 16,),


                  // Confirm Password Field
                  Container(alignment: Alignment.centerLeft, child: Text('Comfirm Password',
                    style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
                  )),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      expands: false,
                      obscureText: isHiddenConfirmPassword,

                      decoration: InputDecoration(
                          fillColor: fillColor,
                          filled: true,
                          border: OutlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: InputBorder.none,

                          hintText: 'Confirm Password',
                          hintStyle: TextStyle(color: iconColor),

                          prefixIcon: isCfmPassEmpty == false ?
                          Icon(Icons.lock,color: Colors.blue,) :
                          Icon(Icons.lock,color: iconColor,),

                          suffixIcon: GestureDetector(
                              onTap: (){
                                setState(() {
                                  isHiddenConfirmPassword = !isHiddenConfirmPassword;
                                });
                              },
                              child:  isHiddenConfirmPassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off)
                          ),
                          suffixIconColor: iconColor
                      ),
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      onSaved: (value) => confirmPassword = value!,
                      onChanged: (value){
                        setState(() {
                          if(value.length > 0){
                            isCfmPassEmpty = false;
                          }
                          else{
                            isCfmPassEmpty = true;
                          }
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: Button(data: createAcc, func: onSubmitHandler ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Already have an account? ", style: TextStyle(fontSize: 10),),
                      GestureDetector(
                        onTap: onClickHandler,
                        child: Text('Login',style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),),
                      )
                    ],
                  ),

                  SizedBox(height: 17,),

                  Container(
                    width: W,
                    alignment: Alignment.center,
                    child: Text(useSocialMedia),
                  ),

                  SizedBox(height: 17,),
                  ContinueButton(data: cntGoogle, func: (){}, src: gLogo),

                  SizedBox(height: 16,),
                  ContinueButton(data: cntTwitter, func: (){}, src: xLogo),

                  SizedBox(height: 16,),
                  ContinueButton(data: cntFacebook, func: (){}, src: fLogo),

                  SizedBox(height: 80,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
