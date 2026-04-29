import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'page/beranda_page.dart';
import 'page/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class ProfileData {
  String fullName;
  String location;
  String email;
  String phone;
  String birthday;
  String occupation;
  String bio;
  List<String> skills;

  ProfileData({
    required this.fullName,
    required this.location,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.occupation,
    required this.bio,
    required this.skills,
  });

  ProfileData copyWith({
    String? fullName,
    String? location,
    String? email,
    String? phone,
    String? birthday,
    String? occupation,
    String? bio,
    List<String>? skills,
  }) {
    return ProfileData(
      fullName: fullName ?? this.fullName,
      location: location ?? this.location,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
      occupation: occupation ?? this.occupation,
      bio: bio ?? this.bio,
      skills: skills ?? this.skills,
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPage = 0;

  ProfileData profile = ProfileData(
    fullName: "Aura Nurdiana",
    location: "Tangerang Selatan, Indonesia",
    email: "auraadiana22@gmail.com",
    phone: "+62 8985943311",
    birthday: "June 22, 2006",
    occupation: "Sistem Informasi at Universitas Pamulang",
    bio:
        "Mahasiswa Sistem Informasi yang memiliki minat dan fokus dalam bidang Mobile Programming. Memiliki kemampuan dalam pengembangan aplikasi mobile menggunakan Flutter serta memahami dasar-dasar UI/UX, integrasi API, dan manajemen data. Aktif belajar dan mengembangkan proyek aplikasi untuk meningkatkan keterampilan teknis.",
    skills: ["Flutter", "UI/UX Design", "Laravel", "Figma", "SQL"],
  );

  void updateProfile(ProfileData newProfile) {
    setState(() {
      profile = newProfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      BerandaPage(profile: profile),
      ProfilePage(profile: profile, onSave: updateProfile),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: pages[currentPage],
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Color(0xffF8F4FB),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: SalomonBottomBar(
            currentIndex: currentPage,
            onTap: (i) => setState(() => currentPage = i),
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black87,
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.home),
                title: const Text("Beranda"),
                selectedColor: Colors.blue,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.person),
                title: const Text("Profile"),
                selectedColor: Colors.blue,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.event),
                title: const Text("Pertemuan 6"),
                selectedColor: Colors.green, // Untuk Pertemuan 6
              ),
            ],
          ),
        ),
      ),
    );
  }
}
