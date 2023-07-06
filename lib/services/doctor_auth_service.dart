library authentication;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mentallance/components/reusable_widgets/reusable_button.dart';
import 'package:mentallance/components/reusable_widgets/reusable_text_field.dart';
import 'package:mentallance/logger.dart';
import 'package:mentallance/theme/app_theme.dart';

part 'package:mentallance/view/Authentication/doctor_authentication/doctor_singin.dart';
part 'package:mentallance/view/Authentication/doctor_authentication/doctor_singup.dart';



void docSingin(econtroller,pcontroller){
   final logg = logger(Doctor_singUp);
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: econtroller,
          password: pcontroller,
        )
        .then((value) {})
        .onError((error, stackTrace) {
      logg.e("Error ${error.toString()}");
    });
  }
void docSingUn(econtroller,pcontroller)async{
  final logg = logger(Doctor_singIn);
    try {
                UserCredential userCredential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: econtroller.text,
                  password: pcontroller.text,
                );
                // User creation successful, do something with the userCredential
                User? user = userCredential.user;
                logg.i('Created user: ${user?.uid}');
              } catch (error) {
                // Handle authentication errors
                logg.e('$error');
              }
  }

  


