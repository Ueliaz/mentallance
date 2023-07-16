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
  final TextEditingController _userSurnameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hesap Oluştur'),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.01, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              
              children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(auth2, height: 150, width: 150,),
              ),
              
              reusableTextField("Adınızı giriniz", Icons.person_outline,
                  false, _userNameTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("Soyadıunızı giriniz", Icons.person_outline,
                  false, _userSurnameTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("mailinizi giriniz", Icons.email_outlined,
                  false, _emailTextController),
              const SizedBox(
                height: 20,
              ),
              reusableTextField("şifrenizi giriniz", Icons.lock_outline,
                  false, _passwordTextController),
              const SizedBox(
                height: 20,
                
              ),
              reusableButton(context, "Sign Up",  (){
                  docSingUp(context,_emailTextController, _passwordTextController,_userNameTextController);
                })
            ]),
          ),
        ));
  }
}

// extendBodyBehindAppBar: true,
//       appBar: customAppBarr(context, 'Hesap Oluştur'),
//       body: SingleChildScrollView(
//           child: Padding(
//         padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const SizedBox(
//               height: 20,
//             ),
//             reusableTextField("Kullanıcı Adınızı giriniz", Icons.person_outline,
//                 false, _userNameTextController),
//             const SizedBox(
//               height: 20,
//             ),
//             reusableTextField("E-mail Adresinizi giriniz", Icons.person_outline,
//                 false, _emailTextController),
//             const SizedBox(
//               height: 20,
//             ),
//             reusableTextField("Şifrenizi giriniz", Icons.lock_outlined, true,
//                 _passwordTextController),
//             const SizedBox(
//               height: 20,
//             ),
//             reusableButton(context, "Sign Up",  (){
//               docSingUp(context,_emailTextController, _passwordTextController,_userNameTextController);

//               //TODO ;
//               //* hesap olusturma icin veri tabanina baglanacak
//               //* hata kontrolu yapilacak
//               // !!! fırebase Sıng up
//             })
//           ],
//         ),
//       )),


//  TextField(
//           controller: _userNameTextController,
//           decoration: InputDecoration(
//             hintText: 'Kullanıcı Adınızı giriniz',
//             icon: Icon(Icons.person_outline),
//           ),
//         ),
//         TextField(
//           controller: _emailTextController,
//           decoration: InputDecoration(
//             hintText: 'E-mail Adresinizi giriniz',
//             icon: Icon(Icons.email_outlined),
//           ),
//         ),
//         TextField(
//           controller: _passwordTextController,
//           decoration: InputDecoration(
//             hintText: 'Şifrenizi giriniz',
//             icon: Icon(Icons.lock_outline),
//           ),
//         ),
//         ElevatedButton(onPressed: (){}, child: Text('Hesap Oluştur'))