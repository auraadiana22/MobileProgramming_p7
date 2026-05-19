import 'package:flutter/material.dart';

class Pertemuan8Page extends StatefulWidget {
  const Pertemuan8Page({super.key});

  @override
  State<Pertemuan8Page> createState() => _Pertemuan8PageState();
}

class _Pertemuan8PageState extends State<Pertemuan8Page> {
  // Data contoh
  final List<String> cities = [
    'Jakarta',
    'Bandung',
    'Surabaya',
    'Medan',
    'Yogyakarta',
    'Bali',
  ];

  final List<String> products = [
    'Laptop',
    'Smartphone',
    'Tablet',
    'Keyboard',
    'Mouse',
  ];

  String? selectedCity;
  String? selectedProduct;
  final TextEditingController _autocompleteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pertemuan 8: AutoComplete & Spinner')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AutoComplete (TextField dengan saran)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue value) {
                if (value.text.isEmpty) return const Iterable<String>.empty();
                return cities.where(
                  (city) =>
                      city.toLowerCase().contains(value.text.toLowerCase()),
                );
              },
              onSelected: (value) {
                _autocompleteController.text = value;
              },
              fieldViewBuilder:
                  (context, controller, focusNode, onEditingComplete) {
                    return TextField(
                      controller: controller,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Ketik nama kota',
                      ),
                    );
                  },
            ),
            const SizedBox(height: 24),
            const Text(
              'Spinner / DropdownButton',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedProduct,
              items: products.map((prod) {
                return DropdownMenuItem<String>(value: prod, child: Text(prod));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedProduct = value;
                });
              },
              hint: const Text('Pilih produk'),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final city = _autocompleteController.text;
                final product = selectedProduct ?? 'Belum dipilih';
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Kota: $city, Produk: $product')),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
