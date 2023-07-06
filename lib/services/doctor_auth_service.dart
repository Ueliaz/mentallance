library authentication;

import 'package:cloud_firestore/cloud_firestore.dart';
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
          email: econtroller.text,
          password: pcontroller.text,
        )
        .then((value) {})
        .onError((error, stackTrace) {
      logg.e("Error ${error.toString()}");
    });
  }




  
void docSingUn(BuildContext context,econtroller,pcontroller,unamecontroller)async{
  final logg = logger(Doctor_singIn);
     try {
                String email = econtroller.text;
                String password = pcontroller.text;

                UserCredential userCredential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );

                // Doktor olusturuluyor
                User? user = userCredential.user;
                print('Doktor Kaydi Gerceklesitirildi: ${user?.uid}');

                // KayitOlanDoktor koleksiyonunda doküman olusturuluyor.
                await FirebaseFirestore.instance
                    .collection('KayitOlanDoktor')
                    .doc(user?.uid)
                    .set({
                  'DoktorIsim': unamecontroller.text,
                  'DoktorSoyisim': " ",
                  'DoktorEmail': email,
                });

                print('"KayitOlanDoktor" koleksiyonunda dokuman olusturuldu.');

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Doktor başarılı bir şekilde kaydedildi!'),
                    backgroundColor: Colors.green,
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Bilgilerinizle giriş yapabilirsiniz.'),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                String errorMessage =
                    'Kayıt işlemi gerçekleştirilemedi.Tekrar deneyiniz.';
                String errorMessage1 = '';

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );

                if (e is FirebaseAuthException) {
                  if (e.code == 'weak-password') {
                    errorMessage1 = 'Şifreniz 6 haneden az olamaz.';
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(errorMessage1),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else if (e.code == 'email-already-in-use') {
                    errorMessage1 =
                        'Bu mail adresi zaten kayıtlı.Farklı bir adres deneyiniz.';
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(errorMessage1),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else if (e.code == 'invalid-email') {
                    errorMessage1 = 'Lütfen geçerli bir mail adresi giriniz.';
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(errorMessage1),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
                print('Sign up failed: $e');
              }
  }

  
