
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentallance/components/reusable_widgets/reusable_button.dart';
import 'package:mentallance/theme/app_theme.dart';
import '../../../components/reusable_widgets/reusable_text_field.dart';

/*
! Bu dosyada Olanlar

* kayit ekrani 
* firebase altyapili Sing Up 

! yapilmasi gerekenler

? password kontrolu
? mail kontrolu
? Firabaseden gelen hatalarin kontrolu

 */

class Doctor_singUp extends StatefulWidget {
  const Doctor_singUp({Key? key}) : super(key: key);

  @override
  _Doctor_singUpState createState() => _Doctor_singUpState();
}

class _Doctor_singUpState extends State<Doctor_singUp> {
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: customAppBarr(context, 'Hesap Oluştur'),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            reusableTextField("Kullanıcı Adınızı giriniz", Icons.person_outline,
                false, _userNameTextController),
            const SizedBox(
              height: 20,
            ),
            reusableTextField("E-mail Adresinizi giriniz", Icons.person_outline,
                false, _emailTextController),
            const SizedBox(
              height: 20,
            ),
            reusableTextField("Şifrenizi giriniz", Icons.lock_outlined, true,
                _passwordTextController),
            const SizedBox(
              height: 20,
            ),
            reusableButton(context, "Sign Up", colorCollection[1], () async {
              try {
                String email = _emailTextController.text;
                String password = _passwordTextController.text;

                UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: email,
                password: password,
              );

                // Danisan olusturuluyor
                User? user = userCredential.user;
                print('Danisan Kaydi Gerceklesitirildi: ${user?.uid}');

                // DanisanKayit koleksiyonunda doküman olusturuluyor.
                await FirebaseFirestore.instance.collection('DanisanKayit').doc(user?.uid).set({
                  'DanisanIsim': _userNameTextController.text,
                  'DanisanEmail': email,
                  'DanisanSoyisim': "",
                  'DanisanYas': "",
                  'DanisanCinsiyet': "",
              });

                print('"DanisanKayit" koleksiyonunda dokuman olusturuldu.');

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Danışan başarılı bir şekilde kaydedildi!'),
                    backgroundColor: Colors.green,
                  ),
                );
            } catch (e) {
                String errorMessage = 'Kayıt işlemi gerçekleştirilemedi.Tekrar deneyiniz.';
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
                  }else if (e.code == 'email-already-in-use') {
                      errorMessage1 = 'Bu mail adresi zaten kayıtlı.Farklı bir adres deneyiniz.';
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(errorMessage1),
                          backgroundColor: Colors.red,
                        ),
                    );
                  }else if(e.code == 'invalid-email'){
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
            })
          ],
        ),
      )),
    );
  }
}

@override
AppBar customAppBarr(BuildContext context, String title) {
  return AppBar(title: Text(title));
}
