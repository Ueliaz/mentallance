import 'package:flutter/material.dart';

import '../../../components/assets.dart';
import '../../../components/reusable_widgets/reusable_button.dart';
import '../../../components/reusable_widgets/reusable_text_field.dart';
import '../../../services/doctor_auth_service.dart';
import '../../../theme/app_theme.dart';
import 'add_client.dart';

class CilendList extends StatefulWidget {
  const CilendList({super.key});

  @override
  State<CilendList> createState() => _CilendListState();
}

class _CilendListState extends State<CilendList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: reusableButton(
                    context, 'YENİ DANISAN Ekle', colorCollection[1], () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>AddClient() ,) );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
