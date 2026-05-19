import 'package:flutter/material.dart';
import '../main.dart';
import '../pertemuan/pertemuan5.dart';
import '../pertemuan/pertemuan6.dart';
import '../pertemuan/pertemuan7.dart';
import '../pertemuan/pertemuan8.dart';
import '../pertemuan/pertemuan9.dart';

class BerandaPage extends StatelessWidget {
  final ProfileData profile;

  const BerandaPage({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final items = [
      _DashboardItem(
        title: "Pertemuan 5",
        color: Colors.pink,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProdukPage()),
          );
        },
      ),
      _DashboardItem(
        title: "Pertemuan 6",
        color: Colors.green,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Pertemuan6Page()),
          );
        },
      ),
      _DashboardItem(
        title: "Pertemuan 7",
        color: Colors.orange,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const RadiobuttonPage()),
          );
        },
      ),
      _DashboardItem(
        title: "Pertemuan 8",
        color: Colors.purple,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Pertemuan8Page()),
          );
        },
      ),
      _DashboardItem(
        title: "Pertemuan 9",
        color: Colors.blue,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Pertemuan9Page()),
          );
        },
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xffF6F6F6),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 22),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xffFF7EB3), Color(0xffFF758C)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: const Center(
                child: Text(
                  "Dashboard",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: GridView.builder(
                  itemCount: items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 18,
                    childAspectRatio: 0.95,
                  ),
                  itemBuilder: (context, index) {
                    final item = items[index];

                    return GestureDetector(
                      onTap: item.onTap,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 34,
                              backgroundColor: item.color.withOpacity(0.12),
                              child: Icon(
                                Icons.menu_book_rounded,
                                color: item.color,
                                size: 38,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              item.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardItem {
  final String title;
  final Color color;
  final VoidCallback onTap;

  _DashboardItem({
    required this.title,
    required this.color,
    required this.onTap,
  });
}
