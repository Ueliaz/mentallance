import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      // Kullanıcı oturum açmamışsa, gerekli işlemleri yapabilirsiniz.
      // Örneğin, giriş sayfasına yönlendirme yapabilirsiniz.
      return Scaffold(
        body: Center(
          child: Text('Kullanıcı oturumu açmamış'),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('KayitOlanDoktor')
              .where('DoktorId', isEqualTo: currentUser.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Hata: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            final patientList = snapshot.data!.docs;

            if (patientList.isEmpty) {
              // Hasta listesi boş ise, gerekli işlemleri yapabilirsiniz.
              // Örneğin, boş liste mesajı görüntüleyebilirsiniz.
              return Scaffold(
                body: Center(
                  child: Text('Hasta bulunamadı'),
                ),
              );
            }

            return ListView.builder(
              itemCount: patientList.length,
              itemBuilder: (context, index) {
                final patientData = patientList[index].data() as Map<String, dynamic>;
                final email = patientData['DanisanEmail'] as String?;

                return ListTile(
                  title: Text(email ?? 'No email found'),
                  subtitle: Text('$email adresine sahip danışan'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
