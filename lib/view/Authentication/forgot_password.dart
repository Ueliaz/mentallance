part of authentication;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(forgotimg),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: reusableButton(
                    context, 'Şifremi unuttum', colorCollection[1], () {
                  
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
