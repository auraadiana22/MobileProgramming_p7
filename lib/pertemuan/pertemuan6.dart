import 'package:flutter/material.dart';

class Pertemuan6Page extends StatefulWidget {
  const Pertemuan6Page({Key? key}) : super(key: key);

  @override
  State<Pertemuan6Page> createState() => _Pertemuan6PageState();
}

class _Pertemuan6PageState extends State<Pertemuan6Page> {
  final _formKey = GlobalKey<FormState>();
  bool isMembaca = false;
  bool isMusik = false;
  bool isOlahraga = false;
  bool isTravelling = false;
  bool isAgree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Data Diri"),
        backgroundColor: const Color.fromARGB(255, 175, 76, 137),
      ),
      body: SingleChildScrollView(
        // Wrap the body with SingleChildScrollView to prevent overflow
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Data Diri",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Nama Lengkap
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Lengkap harus diisi';
                  }
                  return null;
                },
              ),

              // NIM
              TextFormField(
                decoration: const InputDecoration(labelText: 'NIM'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIM harus diisi';
                  }
                  return null;
                },
              ),

              // Kelas
              TextFormField(
                decoration: const InputDecoration(labelText: 'Kelas'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kelas harus diisi';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),
              const Text(
                "Hobi",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Checkbox Hobi
              CheckboxListTile(
                title: const Text("Membaca"),
                value: isMembaca,
                onChanged: (bool? value) {
                  setState(() {
                    isMembaca = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text("Musik"),
                value: isMusik,
                onChanged: (bool? value) {
                  setState(() {
                    isMusik = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text("Olahraga"),
                value: isOlahraga,
                onChanged: (bool? value) {
                  setState(() {
                    isOlahraga = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text("Travelling"),
                value: isTravelling,
                onChanged: (bool? value) {
                  setState(() {
                    isTravelling = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text("Menonton"),
                value: isTravelling,
                onChanged: (bool? value) {
                  setState(() {
                    isTravelling = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              // Checkbox Terms
              CheckboxListTile(
                title: const Text(
                  "Saya menyetujui syarat dan ketentuan yang berlaku",
                ),
                value: isAgree,
                onChanged: (bool? value) {
                  setState(() {
                    isAgree = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              // Submit Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Validate form
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Data telah disubmit')),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
