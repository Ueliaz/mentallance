import 'package:flutter/material.dart';
import 'package:mentallance/components/assets.dart';

import '../../components/custom_widgets/custom_wıdgets.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBarr(context, 'Tanıtım Sayfası'),
        body: DefaultTabController(
          length: 3,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0, 20, 0),
            child: Column(
              children: [
                const TabBar(tabs: [
                  Tab(text: '............................', height: 1),
                  Tab(
                    text: '............................',
                    height: 1,
                  ),
                  Tab(
                    text: '............................',
                    height: 1,
                  ),
                ]),
                Expanded(
                  child: TabBarView(children: [
                    page_1(context),
                    page_2(context),
                    page_3(context),
                  ]),
                ),
              ],
            ),
          ),
        ));
  }
}

Container page_1(context) {
  return Container(
    child: Column(
      
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          flex: 4,
          child: Image.asset(
            introPng,
            height: MediaQuery.of(context).size.height * 0.5,
          ),
        ),
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                  "Mentallance, psikologlar ve danışanlar arasında interaktif bir deneyim sunan yenilikçi bir mobil uygulamadır. Artık psikolojik destek ve danışmanlık ihtiyaçlarınızı uygulama üzerinden kolayca sağlayabilirsiniz."),
            ),
          ),
        ),
        Flexible(
            flex: 1,
            child:
                Image.asset(solaKaydirPng, height: 50, width: 50, scale: 1.5)),
      ],
    ),
  );
}

Container page_2(context) {
    return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          flex: 4,
          child: Image.asset(
            introPng2,
            height: MediaQuery.of(context).size.height * 0.5,
          ),
        ),
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                 "Mentallance, ihtiyaçlarınıza ve hedeflerinize uygun terapi süreci sunar. Psikolojik destek seanslarınızı istediğiniz zaman planlayabilir ve sürecinizi yönetebilirsiniz."),
            ),
          ),
        ),
        Flexible(
            flex: 1,
            child:
                Image.asset(solaKaydirPng, height: 50, width: 50, scale: 1.5)),
      ],
    ),
  );
}

Container page_3(context) {
    return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          flex: 4,
          child: Image.asset(
            introPng3,
            height: MediaQuery.of(context).size.height * 0.5,
          ),
        ),
        Flexible(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                  "Şimdi Mentallance ile tanışma zamanı! \nSağlığınıza biran önce kavuşmanızı diler ve iyi günler dileriz."),
            ),
          ),
        ),
        Flexible(
            flex: 1,
            child:
                ElevatedButton(onPressed: () {
                  
                }, child: Text('Kullanmaya Başla'))
                ),
      ],
    ),
  );
}




/* 
Mentallance, psikologlar ve danışanlar arasında interaktif bir deneyim sunan yenilikçi bir mobil uygulamadır. Artık psikolojik destek ve danışmanlık ihtiyaçlarınızı uygulama üzerinden kolayca sağlayabilirsiniz.




 */





























































// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   int _currentPageIndex = 0;

//   final List<Widget> _pages = [
//     const PageOne(),
//     const PageTwo(),
//     const PageThree(),
//   ];

//   void _nextPage() {
//     if (_currentPageIndex < _pages.length - 1) {
//       setState(() {
//         _currentPageIndex++;
//       });
//     }
//   }

//   void _finish() {
//     // Burada uygulamanın ana sayfasına yönlendirmek veya başka bir işlem yapmak isteyebilirsiniz.
//     // Örnek olarak, Navigator.push ile ana sayfaya yönlendirme yapabilirsiniz.
//   }

//   Widget _getPageLogo(int index) {
//     switch (index) {
//       case 0:
//         return Image.asset('assets/page_1.png', width: 500);
//       case 1:
//         return Image.asset('assets/page_2.png', width: 500);
//       case 2:
//         return Image.asset('assets/page_3.png', width: 500);
//       default:
//         return Container();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: Center(
//               child: _getPageLogo(_currentPageIndex),
//             ),
//           ),
//           _pages[_currentPageIndex],
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   if (_currentPageIndex < _pages.length - 1)
//                     ElevatedButton(
//                       onPressed: _nextPage,
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                       ),
//                       child: const Text('Next'),
//                     ),
//                   if (_currentPageIndex == _pages.length - 1)
//                     ElevatedButton(
//                       onPressed: _finish,
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                       ),
//                       child: const Text('Finish'),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PageOne extends StatelessWidget {
//   const PageOne({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text("Mentallance, psikologlar ve danışanlar arasında interaktif bir deneyim sunan yenilikçi bir mobil uygulamadır. Artık psikolojik destek ve danışmanlık ihtiyaçlarınızı uygulama üzerinden kolayca sağlayabilirsiniz."),
//         ],
//       ),
//     );
//   }
// }

// class PageTwo extends StatelessWidget {
//   const PageTwo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text("Mentallance, ihtiyaçlarınıza ve hedeflerinize uygun terapi süreci sunar. Psikolojik destek seanslarınızı istediğiniz zaman planlayabilir ve sürecinizi yönetebilirsiniz."),
//         ],
//       ),
//     );
//   }
// }

// class PageThree extends StatelessWidget {
//   const PageThree({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text("Mentallance ile psikolojik desteğe ulaşmak artık daha kolay ve erişilebilir. Hayatınızı daha iyi bir zihinsel sağlıkla yaşamak için hemen Mentallance'i indirin ve psikolojiyi cebinize taşıyın!"),
//         ],
//       ),
//     );
//   }
// }
