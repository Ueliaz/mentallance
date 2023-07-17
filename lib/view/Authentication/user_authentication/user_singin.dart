part of authentication;

class UserSingIn extends StatefulWidget {
  const UserSingIn({Key? key});

  @override
  State<UserSingIn> createState() => _UserSingInState();
}

class _UserSingInState extends State<UserSingIn> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  bool _showError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DANISAN GIRIS'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            MediaQuery.of(context).size.height * 0.2,
            20,
            0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              reusableTextField(
                "Kullanıcı Adınızı giriniz",
                Icons.person_outline,
                false,
                _emailTextController,
              ),
              const SizedBox(
                height: 20,
              ),
              reusableTextField(
                "Şifrenizi giriniz",
                Icons.lock_outline,
                true,
                _passwordTextController,
              ),
              const SizedBox(
                height: 5,
              ),
              if (_showError)
                Text(
                  'E-posta ve şifre girilmesi zorunludur.',
                  style: TextStyle(color: Colors.red),
                ),
              forgetPassword(context),
              reusableButton(
                context,
                "Sign In",
                colorCollection[1],
                () {
                  final email = _emailTextController.text;
                  final password = _passwordTextController.text;

                  if (email.isEmpty || password.isEmpty) {
                    setState(() {
                      _showError = true;
                    });
                  } else {
                    // E-posta ve şifre girildiyse giriş işlemlerini yap
                    // ! firebase Auth
                    cusSingIn(context, email, password);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClientProfilePage()),
                    );
                  }
                },
              ),
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ForgotPassword()),
          );
        },
      ),
    );
  }

  void cusSingIn(BuildContext context, String email, String password) {}
}
