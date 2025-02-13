import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test3/services/instances/firebase_messaging_services.dart';
import 'package:test3/services/instances/firestore_services.dart';
import 'package:test3/services/instances/shared_preference_services.dart';
import 'package:test3/services/models/user_model.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign-Up Method
  Future<UserModel?> signUp({
    required String firstName,
    required String lastName,
    required String usernameOrPhoneNumber,
    required String password,
    required String dob,
  }) async {

    try {
      // Create user credentials using email (if usernameOrPhoneNumber is an email)
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _determineEmail(usernameOrPhoneNumber),
        password: password,
      );

      print("User signed up successfully: ${userCredential.user!.uid}");

      // get Fcm Token here
      String? token = await FirebaseMessagingServices().initNotifications();

      // Create user model with all required fields
      UserModel user = UserModel(
        uid: userCredential.user!.uid,
        firstName: firstName,
        lastName: lastName,
        usernameOrPhoneNumber: usernameOrPhoneNumber,
        dob: dob,
        fcm_token: token ?? '',
      );

      // Save user to Firestore
      await FirestoreService().saveUser(user);
      print("User saved in Firestore");

      // store user in shared preferences
      // await SharedPrefsService().saveUser(user);
      // print("User stored in Shared Preferences");

      return user;
    } catch (e) {
      print("Error during signup: $e");
      return null;
    }
  }

  // Login Method
  Future<UserModel?> login(String usernameOrPhoneNumber, String password) async {
    try {
      // Determine if the input is an email or phone number for login
      String email = _determineEmail(usernameOrPhoneNumber);

      // Authenticate using Firebase
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("Login successful: ${userCredential.user!.uid}");

      // Retrieve user details from Firestore
      UserModel? user = await FirestoreService().getUser(userCredential.user!.uid);

      if (user != null) {
        // Store user in shared preferences
        await SharedPrefsService().saveUser(user);
        print("User stored in Shared Preferences");
      }

      return user;
    } catch (e) {
      print("Error during login: $e");
      return null;
    }
  }

  // Logout Method
  Future<void> logout() async {
    // need to do google signout

    await _auth.signOut();
    print("User logged out from Firebase");

    // Clear shared preferences
    await SharedPrefsService().clearUser();
    print("User cleared from Shared Preferences");
  }

  Future<void> signOutUsingGoogle() async {
    try {
      // await _googleSignIn.signOut();
      await _auth.signOut();          // ✅ Sign out from Firebase
      print("User signed out successfully");

      await SharedPrefsService().clearUser();
      print("User cleared from Shared Preferences");
    } catch (e) {
      print("Error signing out: $e");
    }
  }



  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    // store it in preference
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid',userCredential.user!.uid);
    await prefs.setBool('isLoggedIn', true);

    return userCredential;
  }

  // function to determine if input is email or phone
  String _determineEmail(String usernameOrPhoneNumber) {
    if (usernameOrPhoneNumber.contains('@')) {
      return usernameOrPhoneNumber;
    }
    else {
      // Handle phone number logic or map it to an email for Firebase Auth
      return "$usernameOrPhoneNumber@example.com";
    }
  }
}


/*
Change emulator that supports google play services and play_store

 Unhandled Exception: PlatformException(sign_in_failed, com.google.android.gms.common.api.ApiException: 12500: , null, null)
E/flutter ( 7471): #0      GoogleSignInApi.signIn (package:google_sign_in_android/src/messages.g.dart:250:7)
E/flutter ( 7471): <asynchronous suspension>
E/flutter ( 7471): #1      GoogleSignInAndroid._signInUserDataFromChannelData (package:google_sign_in_android/google_sign_in_android.dart:111:3)
E/flutter ( 7471): <asynchronous suspension>
E/flutter ( 7471): #2      GoogleSignIn._callMethod (package:google_sign_in/google_sign_in.dart:278:30)
E/flutter ( 7471): <asynchronous suspension>
E/flutter ( 7471): #3      GoogleSignIn.signIn.isCanceled (package:google_sign_in/google_sign_in.dart:431:5)
E/flutter ( 7471): <asynchronous suspension>
 */