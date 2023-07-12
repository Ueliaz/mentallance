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

  Future<List<String>> getAvailableAppointmentTimes(String doctorId) async {
    final appointmentsSnapshot = await FirebaseFirestore.instance
        .collection('KayitOlanDanisan')
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
        appointmentsSnapshot.docs.map((doc) => doc['RandevuTarihi']).toList();

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
                // Veritabanından randevu saatlerini al
                List<String> availableTimes =
                    await getAvailableAppointmentTimes(doctorId);

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
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
                              // Seçilen randevu saati, müsait saatler arasında yer alıyor

  // Veritabanına randevu kaydını eklemek için gerekli işlemleri gerçekleştirin
  await FirebaseFirestore.instance.collection('Randevular').add({
    'DoktorId': doctorId,
    'DanisanId': FirebaseAuth.instance.currentUser!.uid,
    'RandevuTarihi': today,
    'RandevuSaati': selectedTime,
  });
                              Navigator.of(context).pop();
                            } else {
                              // Kullanıcı bir saat seçmediğinde hata mesajı gösterin
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Hata'),
                                    content: const Text('Lütfen bir saat seçin.'),
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