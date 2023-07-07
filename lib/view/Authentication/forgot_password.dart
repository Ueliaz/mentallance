part of authentication;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(forgotimg),
              reusableTextField("Kullanıcı Adınızı giriniz",
                  Icons.person_outline, false, _emailTextController),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: reusableButton(
                    context, 'Şifremi Unuttum', colorCollection[1], () {
                      resetPassword(context,_emailTextController);

                     }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
