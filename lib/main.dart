import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:sw_de_control_de_mantenimiento/providers/user_provider.dart';
import 'package:sw_de_control_de_mantenimiento/responsive/mobile_screen_layout.dart';
import 'package:sw_de_control_de_mantenimiento/responsive/responsive_layout_screen.dart';
import 'package:sw_de_control_de_mantenimiento/responsive/web_screen_layout.dart';
import 'package:sw_de_control_de_mantenimiento/screens/login_screen.dart';
import 'package:sw_de_control_de_mantenimiento/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyBiHIJ1f-VJ9lQYQsnyPIQz_SHaRJYj3GM',
            appId: '1:400343858973:web:8841f1ca6fd75ae186abf4',
            messagingSenderId: '400343858973',
            projectId: 'swmantenimiento-bd078',
            storageBucket: 'swmantenimiento-bd078.appspot.com'));
  } else {
    await Firebase.initializeApp();
  }
  await ScreenProtector.preventScreenshotOn();
  //await FirebaseMessaging.instance.subscribeToTopic('myTopic');
  FirebaseMessaging.instance.getToken().then((token) {
    print('Token: $token');
  }).catchError((e) {
    print('Error al obtener token: $e');
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Event Fot',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        /*home: PreventScreend()*/
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const ResponsiveLayout(
                      webScreenLayout: WebScreenLayout(),
                      mobileScreenLayout: MobileScreenLayout());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }

              return const LoginScreen();
            }),
      ),
    );
  }
}
