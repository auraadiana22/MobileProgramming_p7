import 'package:flutter/material.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  final List<Map<String, dynamic>> products = [
    {
      "name": "Dress Floral Wanita",
      "price": 275000,
      "rating": 5,
      "image": "assets/images/dress_floral.jpg",
    },
    {
      "name": "Kemeja Wispie Wanita",
      "price": 185000,
      "rating": 4,
      "image": "assets/images/kemeja_wispie.jpg",
    },
    {
      "name": "Cardigan Cream Soft",
      "price": 220000,
      "rating": 4,
      "image": "assets/images/cardigan_cream.jpg",
    },
    {
      "name": "Kulot Cutbray",
      "price": 160000,
      "rating": 4,
      "image": "assets/images/kulot_cutbray.jpg",
    },
    {
      "name": "Cardigan Blue Stripe",
      "price": 210000,
      "rating": 4,
      "image": "assets/images/cardigan_blue.jpg",
    },
  ];

  final List<Map<String, dynamic>> cart = [];

  String formatRupiah(int value) {
    return "Rp $value";
  }

  void addToCart(Map<String, dynamic> product) {
    final index = cart.indexWhere((item) => item["name"] == product["name"]);

    setState(() {
      if (index >= 0) {
        cart[index]["qty"] += 1;
      } else {
        cart.add({...product, "qty": 1});
      }
    });
  }

  int get totalCartCount {
    int total = 0;
    for (var item in cart) {
      total += item["qty"] as int;
    }
    return total;
  }

  int get totalPrice {
    int total = 0;
    for (var item in cart) {
      total += (item["price"] as int) * (item["qty"] as int);
    }
    return total;
  }

  void showCartBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xffFFF5F8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            void refreshAll() {
              setState(() {});
              setModalState(() {});
            }

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 12, 18, 20),
                child: SizedBox(
                  height: 500,
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Shopping Cart",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Expanded(
                        child: cart.isEmpty
                            ? const Center(
                                child: Text("Keranjang masih kosong"),
                              )
                            : ListView.builder(
                                itemCount: cart.length,
                                itemBuilder: (context, index) {
                                  final item = cart[index];
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: Colors.black12),
                                    ),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          child: Image.asset(
                                            item["image"],
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item["name"],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                formatRupiah(item["price"]),
                                                style: const TextStyle(
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                if (cart[index]["qty"] > 1) {
                                                  cart[index]["qty"] -= 1;
                                                } else {
                                                  cart.removeAt(index);
                                                }
                                                refreshAll();
                                              },
                                              icon: const Icon(Icons.remove),
                                            ),
                                            Text(
                                              "${item["qty"]}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                cart[index]["qty"] += 1;
                                                refreshAll();
                                              },
                                              icon: const Icon(Icons.add),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                cart.removeAt(index);
                                                refreshAll();
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            formatRupiah(totalPrice),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Color(0xffEC5FA2),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: cart.isEmpty
                              ? null
                              : () {
                                  Navigator.pop(context);
                                  showCheckoutDialog();
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffEC5FA2),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                          ),
                          child: const Text(
                            "Checkout",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void showCheckoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xffFFF7FA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Text("Checkout"),
          content: Text(
            "Total payment: ${formatRupiah(totalPrice)}\n\nThank you for shopping!",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Close",
                style: TextStyle(color: Colors.black54),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  cart.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Payment successful! Thank you for shopping"),
                  ),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xffC2185B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("Pay Now"),
            ),
          ],
        );
      },
    );
  }

  Widget buildStars(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          size: 18,
          color: Colors.amber,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF4F8),
      appBar: AppBar(
        title: const Text("Daftar Produk"),
        backgroundColor: const Color(0xffEC5FA2),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: showCartBottomSheet,
                icon: const Icon(Icons.shopping_cart),
              ),
              if (totalCartCount > 0)
                Positioned(
                  right: 8,
                  top: 6,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "$totalCartCount",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    item["image"],
                    width: 84,
                    height: 84,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item["name"],
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        formatRupiah(item["price"]),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 4),
                      buildStars(item["rating"]),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    addToCart(item);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "${item["name"]} ditambahkan ke keranjang",
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFCE4EF),
                    foregroundColor: const Color(0xffC2185B),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text("Beli"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
