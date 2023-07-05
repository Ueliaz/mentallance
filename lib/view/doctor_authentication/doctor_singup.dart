import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mentallance/components/reusable_widgets/reusable_button.dart';
import 'package:mentallance/theme/app_theme.dart';

import '../../components/reusable_widgets/reusable_text_field.dart';


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
            reusableButton(context, "Sign Up", colorCollection[1], () {
              //TODO ; 
              //* hesap olusturma icin veri tabanina baglanacak
              //* hata kontrolu yapilacak



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