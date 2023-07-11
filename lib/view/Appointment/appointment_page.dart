part of appointment;

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay){
    setState(() {
      today = day;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [tableCalander(context)],
      )),
    );
  }

  Widget tableCalander(BuildContext context) {
    return Container(
      child: TableCalendar(
        onDaySelected: _onDaySelected,
          rowHeight: 45,
          headerStyle:
              HeaderStyle(formatButtonVisible: false, titleCentered: true),
          availableGestures: AvailableGestures.all,
          selectedDayPredicate: (day) => isSameDay(day, today),
          focusedDay: today,
          firstDay: DateTime(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14)),
    );
  }
}
