import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentallance/components/reusable_widgets/reusable_button.dart';
import 'package:mentallance/components/reusable_widgets/reusable_text_field.dart';
import 'package:mentallance/theme/app_theme.dart';
import 'package:mentallance/view/Authentication/doctor_authentication/doctor_singup.dart';

/*
! Bu dosyada Olanlar

* girs ekrani 
* firebase altyapili Sing in 

! yapilmasi gerekenler

? password kontrolu
? mail kontrolu
? Firabaseden gelen hatalarin kontrolu

 */

class Doctor_singIn extends StatefulWidget {
  const Doctor_singIn({super.key});

  @override
  State<Doctor_singIn> createState() => _Doctor_singInState();
}

class _Doctor_singInState extends State<Doctor_singIn> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr(context, 'DOKTOR GIRIS'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.2, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //logoWidget("assets/images/logo1.png"),
              const SizedBox(
                height: 30,
              ),
              reusableTextField("Kullanıcı Adınızı giriniz",
                  Icons.person_outline, false, _emailTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Şifrenizi giriniz", Icons.lock_outline, true,
                  _passwordTextController),
              const SizedBox(
                height: 5,
              ),
              forgetPassword(context),
              reusableButton(context, "Sign In", colorCollection[1], () async {
                try {
                  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordTextController.text,
                  );
                  User? user = userCredential.user;
                  print('Giris yapan doktor: ${user?.uid}');

    // FireStore'da koleksiyona doküman oluşturuluyor.
                  FirebaseFirestore.instance.collection('GirisYapanDoktor').add({
                  'DoktorId': user?.uid,
                  'DoktorEmail': user?.email,
                  'GirisZamani': DateTime.now(),
                  'DoktorIsim':"",
                  'DoktorSoyIsim':"",
                });

                print('"GirisYapanDoktor" koleksiyonunda dokuman olusturuldu.');

                String welcomeMessage = 'Hoşgeldin, ${user?.email}';
                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(welcomeMessage),
                  backgroundColor: Colors.green,
                ),
              );

              }catch (e) {
                if (e is FirebaseAuthException) {
                  String errorMessage = '';

                  switch (e.code) {
                    case 'user-not-found':
                      errorMessage = 'Kullanıcı bulunamadı. Lütfen geçerli bir e-posta adresi girin.';
                      break;
                    case 'wrong-password':
                      errorMessage = 'Hatalı şifre. Lütfen doğru şifreyi girin.';
                      break;
                    case 'invalid-email':
                      errorMessage = 'Geçersiz e-posta adresi. Lütfen geçerli bir e-posta adresi girin.';
                      break;
                    default:
                      errorMessage = 'Giriş başarısız oldu. Hata: ${e.code}';
                      break;
              }
              
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
                } else {
                  print('Sign in failed: $e');
                }
              }
              }),
              signUpOption()
            ],
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Henüz bir hesaba sahip değil misiniz?",
            style: TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Doctor_singUp(),
                ));
          },
          child: const Text(
            " Hesap oluşur",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
          child: const Text(
            "Şifremi unuttum?",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.right,
          ),
          onPressed: () {}),
    );
  }
}

@override
AppBar customAppBarr(BuildContext context, String title) {
  return AppBar(title: Text(title));
}
