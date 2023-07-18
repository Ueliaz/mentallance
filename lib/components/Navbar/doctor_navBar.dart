part of buttonNavBar;

Widget doctorGNav(context) {
  int _selectedIndex = 0;
  const List<Widget> _widgetOptions = <Widget>[
    MyWidget(),
    IntroductionPage(),
    Text(
      'Index 2: School',
    ),
    Text(
      'Index 3: School',
    ),
  ];
  return Padding(
    padding: const EdgeInsets.all(15),
    child: Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          color: lightColorScheme.onTertiaryContainer),
      child: GNav(
          onTabChange: (index) {},
          color: lightColorScheme.primaryContainer,
          tabBackgroundColor:
              lightColorScheme.primaryContainer.withOpacity(0.2),
          activeColor: lightColorScheme.primaryContainer,
          backgroundColor: Colors.transparent,
          gap: 8,
          padding: EdgeInsets.all(10),
          tabs: const [
            GButton(
              icon: Icons.person,
              text: 'aaaaaa',
            ),
            GButton(
              icon: Icons.home,
              text: 'aaaaaa',
            ),
            GButton(
              icon: Icons.settings,
              text: 'aaaaaa',
            ),
            GButton(
              icon: Icons.settings,
              text: 'aaaaaa',
            ),
          ]),
    ),
  );
}
