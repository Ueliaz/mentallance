part of app_theme;


hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix: 16));
}


var colorCollection =  [
  hexStringToColor('002250'),
  hexStringToColor('4D7AAE'),
  hexStringToColor('74C2C3'),
  hexStringToColor('BDD3DB'),
  hexStringToColor('BFBFBF'),
  hexStringToColor('E9E9E9'),
];