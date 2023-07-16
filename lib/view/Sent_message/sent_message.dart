import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SentMessage extends StatefulWidget {
  const SentMessage({Key? key});

  @override
  _SentMessageState createState() => _SentMessageState();
}

class _SentMessageState extends State<SentMessage> {
  TextEditingController _senderEmailController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  TextEditingController _recipientController = TextEditingController();

  @override
  void dispose() {
    _senderEmailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    _recipientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doktora Mesaj Gönder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _senderEmailController,
              decoration: InputDecoration(
                labelText: 'Gönderen E-posta',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _recipientController,
              decoration: InputDecoration(
                labelText: 'Alıcı E-posta',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(
                labelText: 'Konu',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _messageController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'Mesaj',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                sendEmail();
              },
              child: Text('Gönder'),
            ),
          ],
        ),
      ),
    );
  }

  void sendEmail() {
    final senderEmail = _senderEmailController.text;
    final recipientEmail = _recipientController.text;
    final subject = _subjectController.text;
    final message = _messageController.text;

    // E-posta gönderme işlemleri burada gerçekleştirilebilir
    // senderEmail, recipientEmail, subject, message değerlerini kullanarak e-posta gönderme işlemi yapılabilir
  }
}
