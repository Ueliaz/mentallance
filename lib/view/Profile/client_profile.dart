import 'package:flutter/material.dart';


class ClientProfilePage extends StatefulWidget {
  const ClientProfilePage({super.key});

  @override
  _ClientProfilePageState createState() => _ClientProfilePageState();
}

class _ClientProfilePageState extends State<ClientProfilePage> {
  String name = 'İsim Soyisim';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50.0,
            backgroundImage: AssetImage('assets/client_profile.png'),
          ),
          const SizedBox(height: 16.0),
          Text(
            name,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()),
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        name = value;
                      });
                    }
                  });
                },
                child: const Text('Düzenle'),
              ),
              const SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Mesaj gönderme işlemini gerçekleştir
                },
                child: const Text('Mesaj Gönder'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EditProfilePage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Düzenle'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Kullanıcı Adı',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Şifre',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Telefon Numarası',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Save button pressed
                String name = _nameController.text;
                String email = _emailController.text;
                String password = _passwordController.text;
                String phoneNumber = _phoneNumberController.text;

                // Perform the necessary operations with the entered data
                // For example, you can update the user's profile in the database

                // Return the updated name to the previous screen
                Navigator.pop(context, name);
              },
              child: Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
