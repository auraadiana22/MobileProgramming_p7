import 'package:flutter/material.dart';
import '../main.dart';

class ProfilePage extends StatelessWidget {
  final ProfileData profile;
  final Function(ProfileData) onSave;

  const ProfilePage({super.key, required this.profile, required this.onSave});

  void showEditProfile(BuildContext context) {
    final nameController = TextEditingController(text: profile.fullName);
    final locationController = TextEditingController(text: profile.location);
    final emailController = TextEditingController(text: profile.email);
    final phoneController = TextEditingController(text: profile.phone);
    final birthdayController = TextEditingController(text: profile.birthday);
    final occupationController = TextEditingController(
      text: profile.occupation,
    );
    final bioController = TextEditingController(text: profile.bio);
    final skillsController = TextEditingController(
      text: profile.skills.join(", "),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: const Color(0xffF7F7F7),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 18,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xffFF6FA5), Color(0xffD96CFF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const Text(
                        "Edit Profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          final updated = profile.copyWith(
                            fullName: nameController.text,
                            location: locationController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            birthday: birthdayController.text,
                            occupation: occupationController.text,
                            bio: bioController.text,
                            skills: skillsController.text
                                .split(",")
                                .map((e) => e.trim())
                                .where((e) => e.isNotEmpty)
                                .toList(),
                          );

                          onSave(updated);
                          Navigator.pop(context);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Profile berhasil diperbarui!"),
                            ),
                          );
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(
                      18,
                      18,
                      18,
                      MediaQuery.of(context).viewInsets.bottom + 18,
                    ),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xff8A7CFF),
                                  width: 3,
                                ),
                              ),
                              child: const CircleAvatar(
                                radius: 52,
                                backgroundImage: AssetImage(
                                  "assets/images/profile.jpg",
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: const Color(0xff8A7CFF),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Change Avatar",
                          style: TextStyle(
                            color: Color(0xff6C63FF),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _input("Full Name", Icons.person, nameController),
                        _input(
                          "Location",
                          Icons.location_on,
                          locationController,
                        ),
                        _input("Email", Icons.email, emailController),
                        _input("Phone", Icons.phone, phoneController),
                        _input("Birthday", Icons.cake, birthdayController),
                        _input("Occupation", Icons.work, occupationController),
                        _input(
                          "Bio",
                          Icons.description,
                          bioController,
                          maxLines: 4,
                        ),
                        _input(
                          "Skills (pisahkan dengan koma)",
                          Icons.local_offer,
                          skillsController,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void shareProfile(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Profile shared!")));
  }

  static Widget _input(
    String label,
    IconData icon,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: const Color(0xff7B7CEB)),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Color(0xffEC5FA2), width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget statItem(IconData icon, String value, String label) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.indigo[300], size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  Widget infoTile(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xffEEF0FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.indigo[300]),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Color chipColor(String skill) {
    switch (skill.toLowerCase()) {
      case 'flutter':
        return Colors.blue;
      case 'ui/ux design':
        return Colors.purple;
      case 'laravel':
        return Colors.deepOrange;
      case 'figma':
        return Colors.pink;
      case 'sql':
        return Colors.green;
      default:
        return Colors.indigo;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 210,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/cover.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -50,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 5),
                    ),
                    child: const CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage("assets/images/profile.jpg"),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  statItem(Icons.image, "150", "Posts"),
                  statItem(Icons.group, "10K", "Followers"),
                  statItem(Icons.person_add, "100", "Following"),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "About Me",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      profile.bio,
                      style: const TextStyle(fontSize: 15, height: 1.6),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    "Information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 16),
                  infoTile(Icons.email, profile.email),
                  infoTile(Icons.phone, profile.phone),
                  infoTile(Icons.cake, profile.birthday),
                  infoTile(Icons.work, profile.occupation),
                  const SizedBox(height: 8),
                  const Text(
                    "Skills & Interests",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: profile.skills.map((skill) {
                      final color = chipColor(skill);
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: color.withOpacity(0.25)),
                        ),
                        child: Text(
                          skill,
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () => showEditProfile(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff6C7BFF),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              "Edit Profile",
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: OutlinedButton(
                            onPressed: () => shareProfile(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xff6C7BFF),
                              side: const BorderSide(
                                color: Color(0xff6C7BFF),
                                width: 2,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              "Share Profile",
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
