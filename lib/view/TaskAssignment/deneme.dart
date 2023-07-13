part of TaskAssignment;

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late List<String> patients = [];

  @override
  void initState() {
    super.initState();
    getPatients();
  }

  Future<void> getPatients() async {
    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final doctorId = currentUser.uid;
        final snapshot = await FirebaseFirestore.instance
            .collection('KayitOlanDoktor')
            .doc(doctorId)
            .get();

        final List<String> patientsList = [];

        final danisanlar = snapshot.data()?['Danisanlar'] as List<dynamic>;
        danisanlar.forEach((danisan) {
          final patientId = danisan.toString();
          patientsList.add(patientId);
        });

        setState(() {
          patients = patientsList;
        });
      }
    } catch (e) {
      print('Hastaları alırken hata oluştu: $e');
    }
  }

  void navigateToHastaGorev(String patientId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HastaGorevPage(patientId: patientId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Doktorun Hastaları:'),
          Expanded(
            child: patients.isNotEmpty
                ? ListView.builder(
                    itemCount: patients.length,
                    itemBuilder: (context, index) {
                      final patientId = patients[index];
                      return ListTile(
                        title: Text(patientId),
                        onTap: () {
                          navigateToHastaGorev(patientId);
                        },
                      );
                    },
                  )
                : Center(
                    child: Text('Hastalar yükleniyor...'),
                  ),
          ),
        ],
      ),
    );
  }
}

class HastaGorevPage extends StatefulWidget {
  final String patientId;

  const HastaGorevPage({required this.patientId});

  @override
  State<HastaGorevPage> createState() => _HastaGorevPageState();
}

class _HastaGorevPageState extends State<HastaGorevPage> {
  late TextEditingController _baslikController;
  late TextEditingController _aciklamaController;

  @override
  void initState() {
    super.initState();
    _baslikController = TextEditingController();
    _aciklamaController = TextEditingController();
  }

  @override
  void dispose() {
    _baslikController.dispose();
    _aciklamaController.dispose();
    super.dispose();
  }

  void _gorevAta() async {
    try {
      final User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final doctorId = currentUser.uid;
        final gorevData = {
          'DoktorId': doctorId,
          'DanisanId': widget.patientId,
          'GorevBaslik': _baslikController.text,
          'GorevAciklama': _aciklamaController.text,
          'GorevDurum': 'görev atandı',
        };

        await FirebaseFirestore.instance.collection('Gorev').add(gorevData);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Görev atandı.'),
          ),
        );

        // Görev atandıktan sonra yapılacak diğer işlemler
      }
    } catch (e) {
      print('Görev atama hatası: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasta Görev Sayfası'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hasta ID: ${widget.patientId}'),
            SizedBox(height: 16),
            Text('Görev Başlığı:'),
            TextField(
              controller: _baslikController,
            ),
            SizedBox(height: 16),
            Text('Görev Açıklama:'),
            TextField(
              controller: _aciklamaController,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _gorevAta,
              child: Text('Görev Ata'),
            ),
          ],
        ),
      ),
    );
  }
}
