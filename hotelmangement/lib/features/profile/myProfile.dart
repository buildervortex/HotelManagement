import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotelmangement/features/auth/home.dart';
import 'package:hotelmangement/features/profile/editProfile.dart';
import 'package:hotelmangement/features/profile/logout.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyProfileScreen(),
  ));
}

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --------------------- App Bar -------------------------
            AppBar(
              backgroundColor: const Color.fromARGB(255, 88, 3, 4),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
              ),
              title: const Text(
                "My Profile",
                style: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
              ),
              centerTitle: true,
            ),
            
            // --------------------- Profile Section -------------------------
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  // --------------------- Profile Picture -------------------------
                  GestureDetector(
                    onTap: () {
                      // Add any onTap behavior you want for profile picture
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6), // Increased padding for better border effect
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color.fromARGB(255, 88, 3, 4), const Color.fromARGB(255, 177, 120, 46)], // Gradient effect
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 4,
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 75, // Increased size for a more prominent profile picture
                        backgroundImage: AssetImage('assets/profile/profile.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Profile Items (Card-style Layout)
                  buildProfileCard('Name', 'Ahad Hashmi', CupertinoIcons.person, context),
                  const SizedBox(height: 10),
                  buildProfileCard('Email', 'ahadhashmideveloper@gmail.com', CupertinoIcons.mail, context),
                  const SizedBox(height: 10),
                  buildProfileCard('Phone', '03107085816', CupertinoIcons.phone, context),

                  const SizedBox(height: 30),
                  // --------------------- Edit Profile Button -------------------------
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProfileScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 88, 3, 4),
                        elevation: 6,
                        minimumSize: const Size(500, 60), 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Rounded corners
                        ),
                      ),
                      child: const Text(
                        "Edit Profile",
                        style: TextStyle(
                          fontSize: 22, 
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --------------------- Logout Button -------------------------
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LogoutScreen()),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Color.fromARGB(255, 88, 3, 4), width: 2),
                        elevation: 4,
                        minimumSize: const Size(500, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Rounded corners
                        ),
                      ),
                      child: const Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 88, 3, 4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------- Profile Card Widget -------------------------
  Widget buildProfileCard(String title, String subtitle, IconData iconData, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to ProfileScreen when tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30), 
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 10),
              color: const Color.fromARGB(255, 88, 3, 4).withOpacity(.3),
              spreadRadius: 1,
              blurRadius: 15,
            ),
          ],
          border: Border.all(
            color: const Color.fromARGB(255, 88, 3, 4),
            width: 1.5,
          ),
        ),
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: 'Roboto',
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(fontSize: 18, color: Colors.black54),
          ),
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 88, 3, 4),
              shape: BoxShape.circle,
            ),
            child: Icon(
              iconData,
              color: Colors.white,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward,
            color: Color.fromARGB(255, 88, 3, 4),
            size: 28,
          ),
        ),
      ),
    );
  }
}
