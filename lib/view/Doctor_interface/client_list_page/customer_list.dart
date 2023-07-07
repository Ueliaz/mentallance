library customer;
import 'package:flutter/material.dart';

import '../../../components/assets.dart';
import '../../../components/reusable_widgets/reusable_button.dart';
import '../../../components/reusable_widgets/reusable_text_field.dart';
import '../../../services/doctor_auth_service.dart';
import '../../../theme/app_theme.dart';
import 'add_customer.dart';
part 'package:mentallance/services/add_customer_service.dart';


class CustomerList extends StatefulWidget {
  const CustomerList({super.key});

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
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
