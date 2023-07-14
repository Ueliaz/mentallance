import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../components/assets.dart';
import '../../../components/reusable_widgets/reusable_button.dart';
import '../../../components/reusable_widgets/reusable_text_field.dart';
import '../../../services/add_customer_service.dart';


// Import the CustomerService class

class AddClient extends StatefulWidget {
  const AddClient({super.key});

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  final TextEditingController _emailTextController = TextEditingController();
  final CustomerService _customerService = CustomerService(); // Create an instance of CustomerService
  

  void addCustomerService() {
    final FirebaseAuth auth = FirebaseAuth.instance;

    String email = _emailTextController.text.trim();
    String doctorId = auth.currentUser?.uid ?? ''; // Doktorun ID'sini al
    _customerService.addCustomerService(email, doctorId, context); // Call the addCustomerService method with the doctorId // Call the addCustomerService method

    // Additional operations or UI updates can be performed here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(forgotimg),
              reusableTextField(
                "Kullanıcı Adınızı giriniz",
                Icons.person_outline,
                false,
                _emailTextController,
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: reusableButton(
                  context,
                  'YENİ DANISAN KAYIT',             
                  addCustomerService, // Call the addCustomerService method when the button is pressed
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
