import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = [
    const PageOne(),
    const PageTwo(),
    const PageThree(),
  ];

  void _nextPage() {
    if (_currentPageIndex < _pages.length - 1) {
      setState(() {
        _currentPageIndex++;
      });
    }
  }

  void _finish() {
    // Burada uygulamanın ana sayfasına yönlendirmek veya başka bir işlem yapmak isteyebilirsiniz.
    // Örnek olarak, Navigator.push ile ana sayfaya yönlendirme yapabilirsiniz.
  }

  Widget _getPageLogo(int index) {
    switch (index) {
      case 0:
        return Image.asset('assets/page_1.png', width: 100);
      case 1:
        return Image.asset('assets/page_2.png', width: 100);
      case 2:
        return Image.asset('assets/page_3.png', width: 100);
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: _getPageLogo(_currentPageIndex),
            ),
          ),
          _pages[_currentPageIndex],
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_currentPageIndex < _pages.length - 1)
                    ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      ),
                      child: const Text('Next'),
                    ),
                  if (_currentPageIndex == _pages.length - 1)
                    ElevatedButton(
                      onPressed: _finish,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      ),
                      child: const Text('Finish'),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Mentallance, psikologlar ve danışanlar arasında interaktif bir deneyim sunan yenilikçi bir mobil uygulamadır. Artık psikolojik destek ve danışmanlık ihtiyaçlarınızı uygulama üzerinden kolayca sağlayabilirsiniz."),
        ],
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Mentallance, ihtiyaçlarınıza ve hedeflerinize uygun terapi süreci sunar. Psikolojik destek seanslarınızı istediğiniz zaman planlayabilir ve sürecinizi yönetebilirsiniz."),
        ],
      ),
    );
  }
}

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Mentallance ile psikolojik desteğe ulaşmak artık daha kolay ve erişilebilir. Hayatınızı daha iyi bir zihinsel sağlıkla yaşamak için hemen Mentallance'i indirin ve psikolojiyi cebinize taşıyın!"),
        ],
      ),
    );
  }
}
