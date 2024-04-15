import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import "package:api_rest_flutter/screens/splash_page.dart";
import 'package:api_rest_flutter/screens/home_page.dart';
import 'package:api_rest_flutter/screens/adm_page.dart';
import 'package:api_rest_flutter/screens/edit_item_page.dart';
import 'package:api_rest_flutter/screens/login_page.dart';


void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      initialRoute: '/adm',
      routes: {
        '/': (context) => const Splashpage(),
        '/home': (context) => const HomePage(),
        '/adm': (context) => const AdmPage(),
        '/edit': (context) => const EditItemPage(),
        '/login': (context) => const Login(title: "testestestestestestes"),


        },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}




