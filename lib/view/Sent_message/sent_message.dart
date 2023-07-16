import 'package:flutter/material.dart'
    show
        AppBar,
        Border,
        BoxDecoration,
        BuildContext,
        Center,
        Colors,
        Column,
        Container,
        EdgeInsets,
        ElevatedButton,
        FontWeight,
        InputBorder,
        InputDecoration,
        MainAxisAlignment,
        Padding,
        Scaffold,
        ScaffoldMessenger,
        SizedBox,
        SnackBar,
        State,
        StatefulWidget,
        Text,
        TextEditingController,
        TextField,
        TextStyle,
        Widget;
import 'package:cloud_firestore/cloud_firestore.dart';

class sent_message extends StatefulWidget {
  const sent_message({super.key});

  @override
  _sent_messageState createState() => _sent_messageState();
}

class _sent_messageState extends State<sent_message> {
  final TextEditingController _cevapController = TextEditingController();

  void _sent_message() {
    String soru =
        'Seans sonrası duygu ve düşüncelerinizi paylaşmanız bizim için önemlidir.İsimsiz olarak bizimle düşüncelerinizi  paylaşabilirsiniz.'; // Başlık olarak kullanılacak sabit bir soru metni
    String cevap = _cevapController.text;

    // Firestore koleksiyonuna anketi kaydet
    FirebaseFirestore.instance.collection('mesajlar').add({
      'soru': soru,
      'cevap': cevap,
      'MesajTarihi': DateTime.now(),
    });

    // Text alanını temizle
    _cevapController.clear();

    // Geri bildirim göster
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Mesaj gönderildi')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mesaj Gönderme Sayfası'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Doktora mesaj göndermek için aşağıdaki alanı doldurabilirsiniz.', // Başlık olarak gösterilen sabit soru metni
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: _cevapController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Cevap',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _sent_message,
                child: const Text('Gönder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
