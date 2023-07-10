part of authentication;

Future<void> cusSingin(BuildContext context, econtroller, pcontroller) async {
  final logg = logger(UserSingUp);
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: econtroller.text,
      password: pcontroller.text,
    ).then((value) { Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomerList(),));
      return value;
     });

    User? user = userCredential.user;
    logg.v('Giris yapan doktor: ${user?.uid}');

    FirebaseFirestore.instance.collection('GirisYapanDoktor').add({
      'DoktorId': user?.uid,
      'DoktorEmail': user?.email,
      'GirisZamani': DateTime.now(),
      'DoktorIsim': "",
      'DoktorSoyIsim': "",
    });

    logg.v('"GirisYapanDoktor" koleksiyonunda dokuman olusturuldu.');

    String welcomeMessage = 'Hoşgeldin, ${user?.email}';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(welcomeMessage),
        backgroundColor: Colors.green,
      ),
    );
  } catch (e) {
    if (e is FirebaseAuthException) {
      String errorMessage = '';

      switch (e.code) {
        case 'user-not-found':
          errorMessage =
              'Kullanıcı bulunamadı. Lütfen geçerli bir e-posta adresi girin.';
          logg.e(errorMessage);
          break;
        case 'wrong-password':
          errorMessage = 'Hatalı şifre. Lütfen doğru şifreyi girin.';
          logg.e(errorMessage);
          break;
        case 'invalid-email':
          errorMessage =
              'Geçersiz e-posta adresi. Lütfen geçerli bir e-posta adresi girin.';
          logg.e(errorMessage);
          break;
        default:
          errorMessage = 'Giriş başarısız oldu. Hata: ${e.code}';
          logg.e(errorMessage);
          break;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      logg.e('Sign in failed: $e');
    }
  }
}