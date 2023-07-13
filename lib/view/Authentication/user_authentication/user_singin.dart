part of authentication;

// import '../../../services/auth_service.dart';

/*
! Bu dosyada Olanlar

* girs ekrani 
* firebase altyapili Sing in 

! yapilmasi gerekenler

? password kontrolu
? mail kontrolu
? Firabaseden gelen hatalarin kontrolu

 */

class UserSingIn extends StatefulWidget {
  const UserSingIn({super.key});

  @override
  State<UserSingIn> createState() => _UserSingInState();
}

class _UserSingInState extends State<UserSingIn> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarr(context, 'DANISAN GIRIS'),
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
              reusableButton(context, "Sign In", colorCollection[1], () {
                // ! firebase Auth
                cusSingin(context,_emailTextController, _passwordTextController);
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashScreen()));
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AppointmentPage()));
              }),
              //signUpOption()
            ],
          ),
        ),
      ),
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
            // ! firebase Auth
            
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPassword()));
          }),
    );
  }
}
