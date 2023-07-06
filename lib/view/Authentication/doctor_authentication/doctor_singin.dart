part of authentication;



/*
! Bu dosyada Olanlar

* girs ekrani 
* firebase altyapili Sing in 

! yapilmasi gerekenler

? password kontrolu
? mail kontrolu
? Firabaseden gelen hatalarin kontrolu

 */

class Doctor_singIn extends StatefulWidget {
  const Doctor_singIn({super.key});

  @override
  State<Doctor_singIn> createState() => _Doctor_singInState();
}

class _Doctor_singInState extends State<Doctor_singIn> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  final log = logger(Doctor_singIn);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr(context, 'DOKTOR GIRIS'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.2, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //logoWidget("assets/images/logo1.png"),
              const SizedBox(
                height: 30,
              ),
              reusableTextField("Kullanıcı Adınızı giriniz",
                  Icons.person_outline, false, _emailTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Şifrenizi giriniz", Icons.lock_outline, true,
                  _passwordTextController),
              const SizedBox(
                height: 5,
              ),
              forgetPassword(context),
              // docSingIn(context, _emailTextController, _passwordTextController),
              // ! firebase Auth
              reusableButton(context, "Sign İn", colorCollection[1], (){
                docSingin(_emailTextController, _passwordTextController);
              }),
              signUpOption()
            ],
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Henüz bir hesaba sahip değil misiniz?",
            style: TextStyle(color: Colors.black)),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Doctor_singUp(),
                ));
          },
          child: const Text(
            " Hesap oluşur",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
          child: const Text(
            "Şifremi unuttum?",
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.right,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
          }),
    );
  }
}

@override
AppBar customAppBarr(BuildContext context, String title) {
  return AppBar(title: Text(title));
}

// @override
// Widget docSingIn(BuildContext context, econtroller, pcontroller) {
//   return reusableButton(context, "Sign In", colorCollection[1], () {
//     FirebaseAuth.instance
//         .signInWithEmailAndPassword(
//           email: econtroller.text,
//           password: pcontroller.text,
//         )
//         .then((value) {})
//         .onError((error, stackTrace) {
//       print("Error ${error.toString()}");
//     });
//     // ! firebase Auth
//   });
// }
