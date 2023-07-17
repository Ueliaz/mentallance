import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mentallance/theme/color_schemes.g.dart';

import 'package:mentallance/view/entry_page/entry_page_view_mobile.dart';
import 'firebase_options.dart';
import 'view/introduction_page/introduction.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const IntroductionPage(),
    );
  }
}
