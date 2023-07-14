part of authentication;

/*
! Bu dosyada Olanlar

* kayit ekrani 
* firebase altyapili Sing Up 

! yapilmasi gerekenler

? password kontrolu
? mail kontrolu
? Firabaseden gelen hatalarin kontrolu

 */

class UserSingUp extends StatefulWidget {
  const UserSingUp({Key? key}) : super(key: key);

  @override
  _UserSingUpState createState() => _UserSingUpState();
}

class _UserSingUpState extends State<UserSingUp> {
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: customAppBarr(context, 'Hesap Oluştur'),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            reusableTextField("Kullanıcı Adınızı giriniz", Icons.person_outline,
                false, _userNameTextController),
            const SizedBox(
              height: 20,
            ),
            reusableTextField("E-mail Adresinizi giriniz", Icons.person_outline,
                false, _emailTextController),
            const SizedBox(
              height: 20,
            ),
            reusableTextField("Şifrenizi giriniz", Icons.lock_outlined, true,
                _passwordTextController),
            const SizedBox(
              height: 20,
            ),
            reusableButton(context, "Sign Up",  (){
              docSingUp(context,_emailTextController, _passwordTextController,_userNameTextController);

              //TODO ;
              //* hesap olusturma icin veri tabanina baglanacak
              //* hata kontrolu yapilacak
              // !!! fırebase Sıng up
            })
          ],
        ),
      )),
    );
  }
}

