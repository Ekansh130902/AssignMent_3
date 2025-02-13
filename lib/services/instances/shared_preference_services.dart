
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test3/services/models/user_model.dart';

class SharedPrefsService{

  Future<void> saveUser(UserModel user) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid',user.uid);
    await prefs.setBool('isLoggedIn', true);
  }

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    return isLoggedIn;
  }

  // Future<UserModel?> getUser() async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if(prefs.getBool('isLoggedIn') == true){
  //     return UserModel(
  //       uid: prefs.getString('uid')!,
  //       username: prefs.getString('username')!,
  //       email: prefs.getString('email')!,
  //     );
  //   }
  //   return null;
  // }


  Future<void> clearUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

}