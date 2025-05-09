import 'package:flutter/material.dart';
import 'package:hotelmangement/features/auth/login.dart';
import 'package:hotelmangement/features/profile/editProfile.dart';
import 'package:hotelmangement/features/profile/myProfile.dart';
import 'package:hotelmangement/features/profile/logout.dart';

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 88, 3, 4),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
        ),
        actions: [
          PopupMenuButton<int>(
             icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              if (value == 1) {
                // Navigate to MyProfilePage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyProfileScreen()),
                );
              } 
              else if (value == 2) {
                
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              }else if (value == 4) {
                
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LogoutScreen()),
                );
              }
              
            },
            itemBuilder: (context) => [
              const PopupMenuItem<int>(value: 1, child: Text("My Profile")),
              const PopupMenuItem<int>(value: 2, child: Text("Edit Profile")),
              const PopupMenuItem<int>(value: 3, child: Text("Settings")),
              const PopupMenuItem<int>(value: 4, child: Text("Logout")),
            ],
          ),
        ],
      ),

      body: const Center(
        child: Text(
          "Welcome to Home Screen",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}


