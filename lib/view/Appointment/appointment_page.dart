part of appointment;

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  DateTime today = DateTime.now();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  Future<List<String>> getDoctorAppointments(String doctorId) async {
  List<String> appointments = [];
  

  try {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection('KayitOlanDoktor')
        .doc(doctorId)
        .get();

    Map<String, dynamic>? data = querySnapshot.data();

    if (data != null && data.containsKey('DoktorRandevu')) {
      // Firestore'da randevu saatlerini sakladığınız varsayılarak,
      // DoktorRandevu alanından saatleri alıyoruz.
      data['DoktorRandevu'].forEach((key, value) {
        appointments.add(value);
      });
    }
  } catch (e) {
    print('Randevu saatleri alınamadı: $e');
  }

  return appointments;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            tableCalendar(context),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Saat seçimi butonuna basıldığında yapılacak işlemler
              },
              child: const Text('Saat Seçimi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget tableCalendar(BuildContext context) {
    return Container(
      child: TableCalendar(
        onDaySelected: _onDaySelected,
        rowHeight: 45,
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
        availableGestures: AvailableGestures.all,
        selectedDayPredicate: (day) => isSameDay(day, today),
        focusedDay: today,
        firstDay: DateTime(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
      ),
    );
  }
}
