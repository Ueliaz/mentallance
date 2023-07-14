part of TaskAssignment;

class TaskAssignmentPage extends StatefulWidget {
  const TaskAssignmentPage({super.key});

  @override
  _TaskAssignmentPageState createState() => _TaskAssignmentPageState();
}

class _TaskAssignmentPageState extends State<TaskAssignmentPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final Completer _primaryCompleter = Completer();

  var DoktorId;

  var DanisanId;

  late String taskId;

  Future<String?> getDoctorId(String taskId) {
    DocumentReference taskRef =
        FirebaseFirestore.instance.collection('Gorevler').doc(taskId);
    return taskRef.get().then((task) {
      Map<String, dynamic>? taskData = task.data() as Map<String, dynamic>?;
      return taskData?['doktorId'];
    });
  }

  Future<String?> getPatientId(String taskId) {
    DocumentReference taskRef =
        FirebaseFirestore.instance.collection('Gorevler').doc(taskId);
    return taskRef.get().then((task) {
      Map<String, dynamic>? taskData = task.data() as Map<String, dynamic>?;
      return taskData?['hastaId'];
    });
  }

  Future<bool> isTaskCompleted(String taskId) {
    DocumentReference taskRef =
        FirebaseFirestore.instance.collection('Gorevler').doc(taskId);
    return taskRef.get().then((task) {
      Map<String, dynamic>? taskData = task.data() as Map<String, dynamic>?;
      return taskData?['tamamlandi'] ?? false;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _primaryCompleter.complete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Görev Atama Sayfası'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Görev Başlığı',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0),
                ),
              ),
            ),
            const Spacer(),
            const SizedBox(height: 8.0),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: TextField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Görev Açıklaması',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Ekle butonuna basıldığında yapılacak işlemler
                String title = _titleController.text;
                String description = _descriptionController.text;
                String? doctorId = await getDoctorId(taskId);
                String? patientId = await getPatientId(taskId);

                // Görev verilerini kullanarak işlemler yapabilirsiniz, örneğin veritabanına kaydetme gibi.
                // Örneğin, Firebase Firestore'a bir görev kaydetmek için aşağıdaki kodu kullanabilirsiniz:
                FirebaseFirestore.instance.collection('Gorevler').add({
                  'baslik': title,
                  'aciklama': description,
                  'doktorId': DoktorId,
                  'hastaId': DanisanId,
                  'tamamlandi': false,
                });
                _primaryCompleter.complete();
              },
              child: const Text('Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}
