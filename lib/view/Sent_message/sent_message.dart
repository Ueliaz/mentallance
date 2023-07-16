import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ComposeEmail extends StatefulWidget {
  const ComposeEmail({Key? key});

  @override
  _ComposeEmailState createState() => _ComposeEmailState();
}

class _ComposeEmailState extends State<ComposeEmail> {
  TextEditingController _toController = TextEditingController();
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _fromController = TextEditingController();

  @override
  void dispose() {
    _toController.dispose();
    _subjectController.dispose();
    _fromController.dispose();
    super.dispose();
  }
void _sendEmail() {
  String to = _toController.text;
  String subject = _subjectController.text;
  String from = _fromController.text;
  String mailId = generateRandomId(); // Rastgele bir mail ID oluşturma

  // Firestore koleksiyonuna e-postayı kaydetme
  FirebaseFirestore.instance.collection('Mailler').doc(mailId).set({
    'AliciMail': to,
    'GonderenMail': from,
    'Konu': subject,
    'MailId': mailId,
    'timestamp': DateTime.now(),
  }).then((value) {
    // Gönderildikten sonra, kullanıcıyı ana sayfaya yönlendirebilirsiniz
    Navigator.pop(context);
  }).catchError((error) {
    // Hata durumunda kullanıcıya bilgi verebilirsiniz
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred while sending the email.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  });
}

String generateRandomId() {
  // Rastgele bir mail ID oluşturmak için kullanılabilir
  // İsteğe bağlı olarak farklı bir yöntem kullanabilirsiniz
  return UniqueKey().toString();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compose Email'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _toController,
              decoration: InputDecoration(
                labelText: 'To',
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(
                labelText: 'Subject',
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _fromController,
              decoration: InputDecoration(
                labelText: 'From',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _sendEmail,
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
