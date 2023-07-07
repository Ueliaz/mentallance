
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

class CustomerService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addCustomerService(String email) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: generateRandomPassword(8),
      );

      await resetPassword(email);

      // Veritabanı işlemleri yapılacak.

      print('New customer created with email: $email');
      print('Password reset email sent successfully');
    } catch (e) {
      print('Error adding customer: $e');
      // Handle the error
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
    String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    Random random = Random();
    String password = '';

    for (int i = 0; i < length; i++) {
      int index = random.nextInt(characters.length);
      password += characters[index];
    }

    return password;
  }
}
