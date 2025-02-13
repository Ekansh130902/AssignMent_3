
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test3/auth/login.dart';
import 'package:test3/auth/signup.dart';
import 'package:test3/consts/styles/style.dart';
import 'package:test3/pages/chat.dart';
import 'package:test3/pages/splash_screen.dart';
import 'package:test3/services/instances/firebase_messaging_services.dart';
import 'package:test3/services/instances/shared_preference_services.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling background message: ${message.messageId}");
}

final navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: API_KEY); // check where
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform, // Manually set Firebase options
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessagingServices().initNotifications();

  // Enable Crashlytics error logging
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error,stack){
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };

  // check if user is already login or not
  SharedPrefsService pref = SharedPrefsService();
  bool? isLoggedIn = await pref.checkLoginStatus();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    W = w;
    H = h;

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.urbanistTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white
      ),
      home:
      isLoggedIn ? ChatBot() : SplashScreen()
      // ChatBot()

      // SignupForm()
    );
  }
}

