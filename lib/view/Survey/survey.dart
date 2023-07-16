import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnketDoldur extends StatefulWidget {
  const AnketDoldur({super.key});

  @override
  _AnketDoldurState createState() => _AnketDoldurState();
}

class _AnketDoldurState extends State<AnketDoldur> {
  final TextEditingController _cevapController = TextEditingController();

  void _anketiGonder() {
    String soru =
        'Seans sonrası duygu ve düşüncelerinizi paylaşmanız bizim için önemlidir.İsimsiz olarak bizimle düşüncelerinizi  paylaşabilirsiniz.'; // Başlık olarak kullanılacak sabit bir soru metni
    String cevap = _cevapController.text;

    // Firestore koleksiyonuna anketi kaydet
    FirebaseFirestore.instance.collection('anketler').add({
      'soru': soru,
      'cevap': cevap,
      'AnketTarihi': DateTime.now(),
    });

    // Text alanını temizle
    _cevapController.clear();

    // Geri bildirim göster
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Anket gönderildi')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anket Doldurma Sayfası'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Seans sonrası duygu ve düşüncelerinizi paylaşmanız bizim için önemlidir.İsimsiz olarak bizimle  düşüncelerinizi paylaşabilirsiniz.', // Başlık olarak gösterilen sabit soru metni
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
                onPressed: _anketiGonder,
                child: const Text('Gönder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
