import 'package:flutter/material.dart';
import 'package:mentallance/view/Doctor_interface/client_list_page/customer_list.dart';
import '../../../components/assets.dart';
import '../../../components/reusable_widgets/reusable_button.dart';
import '../../../components/reusable_widgets/reusable_text_field.dart';
import '../../../services/doctor_auth_service.dart';
import '../../../theme/app_theme.dart';

class AddClient extends StatefulWidget {
  const AddClient({super.key});

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(forgotimg),
              reusableTextField("Kullanıcı Adınızı giriniz",
                  Icons.person_outline, false, _emailTextController),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: reusableButton(
                    context, 'YENİ DANISAN KAYIT', colorCollection[1], () {
                  addCustomerService();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
