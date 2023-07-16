import 'package:flutter/material.dart';
import 'package:mentallance/view/Sent_message/sent_message.dart';

class ClientProfilePage extends StatefulWidget {
  @override
  _ClientProfilePageState createState() => _ClientProfilePageState();
}

class _ClientProfilePageState extends State<ClientProfilePage> {
  String name = 'İsim Soyisim';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50.0,
            backgroundImage: AssetImage('assets/doctor_profile.png'),
          ),
          SizedBox(height: 16.0),
          Text(
            name,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Perform send message functionality
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SentMessage()));
                },
                child: Text('Mesaj Gönder'),
              ),
              SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Perform make an appointment functionality
                },
                child: Text('Randevu Al'),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Container(), // Empty Container
        ],
      ),
    );
  }
}
