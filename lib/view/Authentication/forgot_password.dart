import 'package:flutter/material.dart';
import 'package:mentallance/components/assets.dart';




class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [
      Image.asset(forgotimg)

    ]),);
  }
}