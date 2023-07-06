import 'package:flutter/material.dart';
import 'package:mentallance/components/assets.dart';
import 'package:mentallance/components/reusable_widgets/reusable_button.dart';
import 'package:mentallance/theme/app_theme.dart';
import 'package:mentallance/view/Authentication/user_authentication/user_singin.dart';
import '../../services/doctor_auth_service.dart';

class EntryPageView extends StatelessWidget {
  const EntryPageView({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [colorCollection[1], colorCollection[2]])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              
              children: [
                Image.asset(logo),
                Padding(
                  padding: const EdgeInsets.only( left: 50.0,right:50.0, top: 20),
                  child: reusableButton(context, 'Danisan Giris', colorCollection[1],(){Navigator.push(context, MaterialPageRoute(builder: (context) => User_singIn()));}),
                ),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: reusableButton(context, 'Doktor Giris', colorCollection[1],(){Navigator.push(context, MaterialPageRoute(builder: (context) => Doctor_singIn()));}),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
