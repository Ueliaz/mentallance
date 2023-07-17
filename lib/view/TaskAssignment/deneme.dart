part of TaskAssignment;
class MyWidget extends StatefulWidget {
  const MyWidget({Key? key});
  @override
  State<MyWidget> createState() => _MyWidgetState();
}
class _MyWidgetState extends State<MyWidget> {
  late List<Map<String, dynamic>> patients = [];
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
            .collection('KayitOlanDanisan')
            .where('DoktorId', isEqualTo: doctorId)
            .get();
        final List<Map<String, dynamic>> patientsList = [];
        snapshot.docs.forEach((doc) {
          final patientData = doc.data();
          patientsList.add(patientData);
        });
        setState(() {
          patients = patientsList;
        });
      }
    } catch (e) {
      Text("Hata oluştu: $e");
      print('Hastaları alırken hata oluştu: $e');
    }
  }
  void navigateToHastaGorev(String patientId, String patientEmail) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HastaGorevPage(patientId: patientId,patientEmail: patientEmail,),
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
                      final patientId = patients[index]['DanisanId'];
                      final patientEmail = patients[index]['DanisanEmail'];
                      return ListTile(
                        title: Text('ID: $patientId'),
                        subtitle: Text('Email: $patientEmail'),
                        onTap: () {
                          navigateToHastaGorev(patientId, patientEmail);
                        },
                      );
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ],
      ),
    );
  }
}
class HastaGorevPage extends StatefulWidget {
  final String patientId;
  final String patientEmail;
  const HastaGorevPage({required this.patientId, required this.patientEmail,});
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
          'GorevTamamlanma' : false,
        };
      final newGorevRef = await FirebaseFirestore.instance.collection('Gorev').add(gorevData);
      final newGorevId = newGorevRef.id;
      await newGorevRef.update({'GorevId': newGorevId});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Danışana görev atandı.'),
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
            Text('E-posta: ${widget.patientEmail}'),
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
