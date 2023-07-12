import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mentallance/services/appointment_service.dart';
import 'package:mentallance/view/entry_page/entry_page_view_mobile.dart';
import 'firebase_options.dart';
import 'package:table_calendar/table_calendar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Mentallance',
      // theme: ,
      
      home: EntryPageView()
    );
  }
}