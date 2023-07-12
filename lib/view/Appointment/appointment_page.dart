part of appointment;

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  DateTime today = DateTime.now();
  String doctorId = '';
  String selectedTime = '';

  Future<void> addAppointment(
      String selectedDoctorId, String userId, String selectedTime) async {
    final userSnapshot = await FirebaseFirestore.instance
        .collection('KayitOlanDanisan')
        .doc(userId)
        .get();

    final userDoctorId = userSnapshot['DoktorId'];

    final existingAppointmentSnapshot = await FirebaseFirestore.instance
        .collection('Randevular')
        .where('DoktorId', isEqualTo: userDoctorId)
        .where('RandevuTarihi', isEqualTo: today)
        .where('RandevuSaati', isEqualTo: selectedTime)
        .get();

    if (existingAppointmentSnapshot.docs.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Hata'),
            content: const Text(
                'Seçilen saatte başka bir randevu bulunuyor. Lütfen başka bir saat seçin.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Tamam'),
              ),
            ],
          );
        },
      );
      return;
    }

    await FirebaseFirestore.instance.collection('Randevular').add({
      'DoktorId': userDoctorId,
      'DanisanId': userId,
      'RandevuTarihi': today,
      'RandevuSaati': selectedTime,
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Başarılı'),
          content: const Text('Randevu başarıyla alındı.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tamam'),
            ),
          ],
        );
      },
    );
  }

  Future<List<String>> getAvailableAppointmentTimes(String doctorId) async {
    final appointmentsSnapshot = await FirebaseFirestore.instance
        .collection('Randevular')
        .where('DoktorId', isEqualTo: doctorId)
        .get();

    final List<String> allAppointmentTimes = [
      '08.00',
      '09.00',
      '10.00',
      '11.00',
      '13.00',
      '14.00',
      '15.00',
      '16.00'
    ];

    final List reservedAppointmentTimes =
        appointmentsSnapshot.docs.map((doc) => doc['RandevuSaati']).toList();

    final List<String> availableAppointmentTimes = allAppointmentTimes
        .where((time) => !reservedAppointmentTimes.contains(time))
        .toList();

    return availableAppointmentTimes;
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
              onPressed: () async {
                List<String> availableTimes =
                    await getAvailableAppointmentTimes(doctorId);

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return AlertDialog(
                          title: const Text('Randevu Saatini Seçin'),
                          content: SingleChildScrollView(
                            child: Column(
                              children: availableTimes.map((time) {
                                return RadioListTile(
                                  title: Text(time),
                                  value: time,
                                  groupValue: selectedTime,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedTime = value!;
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                if (availableTimes.contains(selectedTime)) {
                                  await addAppointment(
                                      doctorId,
                                      FirebaseAuth.instance.currentUser!.uid,
                                      selectedTime);
                                  Navigator.of(context).pop();
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Hata'),
                                        content: const Text(
                                            'Lütfen bir saat seçin.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Tamam'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: const Text('Seç'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
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

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }
}
