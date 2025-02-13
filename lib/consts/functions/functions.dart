import 'package:email_validator/email_validator.dart';

// check if username is email
bool isEmail(String input) => EmailValidator.validate(input);

// check if Username is phone number
bool isPhone(String input) => RegExp(
    r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$'
).hasMatch(input);

// password validations
String? checkPassword(String value) {
  if (value.isEmpty ||
      value.length < 8 ||
      !RegExp(r'[A-Z]').hasMatch(value) ||
      !RegExp(r'[0-9]').hasMatch(value) ||
      !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
    return 'Password must be at least 8 characters long, contain at least one uppercase letter, one number, and one special character.';
  }
  return null;
}


// Username Validator
String? userNameValidator(String value){
    value = value.trim();
    if (!isEmail(value) && !isPhone(value)) {
      return 'Please enter a valid email or phone number.';
    }
    return null;
}

// abstract class navigator {
//      abstract void push1()
//     void  push<T extends Widget>(BuildContext context, T page) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) {
//         return page; // Use the passed widget as the page
//       }),
//     );
//   }
// }




