import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomerService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addCustomerService(String email, BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: generateRandomPassword(8),
      );

      await resetPassword(email);

      print('New customer created with email: $email');
      print('Password reset email sent successfully');
    } catch (e) {
      print('Error adding customer: $e');
      // Show error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Hata'),
          content: Text('Bir hata oluştu: $e'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Kapat'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Error sending password reset email: $e');
    }
  }

  String generateRandomPassword(int length) {
    String characters =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    Random random = Random();
    String password = '';

    for (int i = 0; i < length; i++) {
      int index = random.nextInt(characters.length);
      password += characters[index];
    }

    return password;
  }
}
