import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugarcheck/Initail%20login%20Module/Login.Page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);

    if (mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  final List<Map<String, dynamic>> services = [
    {'title': 'Book Appointment', 'icon': Icons.calendar_today, 'color': const Color(0xFF4A90E2)},
    {'title': 'Medical Journey', 'icon': Icons.medical_information, 'color': const Color(0xFF50E3C2)},
    {'title': 'Chat with Us', 'icon': Icons.chat, 'color': const Color(0xFFF5A623)},
    {'title': 'Indoor Maps', 'icon': Icons.map, 'color': const Color(0xFFD0024B)},
    {'title': 'Pharmacy', 'icon': Icons.local_pharmacy, 'color': const Color(0xFF9B59B6)},
    {'title': 'Lab Services', 'icon': Icons.science, 'color': const Color(0xFF3498DB)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A90E2),
        elevation: 0,
        title: const Text('SugarCheck', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(onPressed: _logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: Column(
        children: [
          _buildProfileSection(),
          _buildWelcomeText(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) => _buildServiceCard(services[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF4A90E2), Color(0xFF357ABD)]),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
              child: _profileImage == null
                  ? const Icon(Icons.camera_alt, size: 30, color: Color(0xFF4A90E2))
                  : null,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Tap to upload photo',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeText() {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text('Welcome back! 👋', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text('Manage your health services', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: (service['color'] as Color).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(service['icon'], size: 40, color: service['color']),
            ),
            const SizedBox(height: 12),
            Text(service['title'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}