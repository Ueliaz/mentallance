import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage({Key? key}) : super(key: key);

  @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  String name = 'İsim Soyisim';

  @override
  void initState() {
    super.initState();
    loadDoctorProfile();
  }

  Future<void> loadDoctorProfile() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final doctorId = currentUser?.uid;
    final doctorSnapshot = await FirebaseFirestore.instance
        .collection('KayitOlanDoktor')
        .doc(doctorId)
        .get();

    if (doctorSnapshot.exists) {
      final doctorData = doctorSnapshot.data();
      setState(() {
        name = '${doctorData?['DoktorIsim']} ${doctorData?['DoktorSoyisim']}';
      });
    }
  }

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
            backgroundImage: AssetImage('assets/doctor_profile.png'),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WriteBlogPage()),
                  );
                },
                child: const Text('Blog Yaz'),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyBlogsPage()),
              );
            },
            child: const Text('Yazılarım'),
          ),
        ],
      ),
    );
  }
}

class WriteBlogPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  final CollectionReference blogYazilariCollection =
      FirebaseFirestore.instance.collection('BlogYazilari');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Yazısı Oluştur'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Başlık',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _contentController,
              maxLines: 10,
              decoration: const InputDecoration(
                labelText: 'Yazı',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String title = _titleController.text;
                String content = _contentController.text;

                final currentUser = FirebaseAuth.instance.currentUser;
                final doctorId = currentUser?.uid;
                final doctorSnapshot = await FirebaseFirestore.instance
                    .collection('KayitOlanDoktor')
                    .doc(doctorId)
                    .get();

                if (doctorSnapshot.exists) {
                  final doctorData = doctorSnapshot.data();

                  String doktorIsim =
                      '${doctorData?['DoktorIsim']} ${doctorData?['DoktorSoyisim']}';

                  // Verileri Firebase'e kaydet
                  await blogYazilariCollection.add({
                    'DoktorId': doctorId,
                    'DoktorIsim': doctorData?['DoktorIsim'],
                    'DoktorSoyisim': doctorData?['DoktorSoyisim'],
                    'BlogBaslik': title,
                    'BlogYazi': content,
                  });

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Başarılı'),
                        content: const Text('Blog yazınız paylaşıldı.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text('Tamam'),
                          ),
                        ],
                      );
                    },
                  );

                  // Gönderildikten sonra sayfayı kapat
                  // Navigator.pop(context);
                }
              },
              child: const Text('Gönder'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyBlogsPage extends StatefulWidget {
  @override
  _MyBlogsPageState createState() => _MyBlogsPageState();
}

class _MyBlogsPageState extends State<MyBlogsPage> {
  late Stream<QuerySnapshot> blogsStream;

  @override
  void initState() {
    super.initState();
    loadBlogs();
  }

  void loadBlogs() {
    final currentUser = FirebaseAuth.instance.currentUser;
    final doctorId = currentUser?.uid;

    blogsStream = FirebaseFirestore.instance
        .collection('BlogYazilari')
        .where('DoktorId', isEqualTo: doctorId)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yazılarım'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: blogsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final blogs = snapshot.data!.docs;

            if (blogs.isEmpty) {
              return Center(
                child: const Text('Henüz blog yazısı paylaşılmamış.'),
              );
            }

            return ListView.builder(
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                final blog = blogs[index];

                final blogBaslik = blog['BlogBaslik'];
                final blogYazi = blog['BlogYazi'];

                return ListTile(
                  title: Text(blogBaslik),
                  subtitle: Text(blogYazi),
                );
              },
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Hata: ${snapshot.error}'),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class EditProfilePage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final CollectionReference _doctorsCollection =
      FirebaseFirestore.instance.collection('KayitOlanDoktor');

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final doctorId = currentUser?.uid;

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
                labelText: 'Adı',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _surnameController,
              decoration: InputDecoration(
                labelText: 'Soyadı',
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
                labelText: 'Yeni Şifre',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String name = _nameController.text;
                String surname = _surnameController.text;
                String email = _emailController.text;
                String newPassword = _passwordController.text;

                await _doctorsCollection.doc(doctorId).update({
                  'DoktorIsim': name,
                  'DoktorSoyisim': surname,
                  'DoktorEmail': email,
                });

                await currentUser?.updatePassword(newPassword);

                Navigator.pop(context, '$name $surname');
              },
              child: Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
