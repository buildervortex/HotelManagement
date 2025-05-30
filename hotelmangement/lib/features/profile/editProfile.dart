import 'package:flutter/material.dart';
import 'package:hotelmangement/features/auth/home.dart';
import 'package:hotelmangement/features/profile/myProfile.dart';

void main() {
  runApp(const MaterialApp(
    home: ProfileScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void saveProfile(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Icon(Icons.check_circle,
                  color: Color.fromARGB(255, 88, 3, 4), size: 60),
              SizedBox(height: 10),
              Text(
                "Profile Updated!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 88, 3, 4),
                ),
              ),
            ],
          ),
          content: Text(
            "Your profile has been successfully updated.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyProfileScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 88, 3, 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text(
                  "OK",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            _buildTextField(controller: nameController, hintText: "Full Name"),
            const SizedBox(height: 16),
            _buildTextField(
                controller: emailController,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 16),
            _buildTextField(
                controller: phoneController,
                hintText: "Phone Number",
                keyboardType: TextInputType.phone),
            const SizedBox(height: 16),
            _buildTextField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true),
            const SizedBox(height: 40),
            OutlinedButton(
              onPressed: () => saveProfile(context),
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 88, 3, 4),
                side: const BorderSide(
                    color: Color.fromARGB(255, 88, 3, 4), width: 2),
                elevation: 4,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                "Save Profile",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 88, 3, 4), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 88, 3, 4), width: 2),
        ),
        prefixIcon: Icon(
          hintText.contains("Name")
              ? Icons.person
              : hintText.contains("Email")
                  ? Icons.email
                  : hintText.contains("Phone")
                      ? Icons.phone
                      : Icons.lock,
          color: const Color.fromARGB(255, 88, 3, 4),
        ),
      ),
    );
  }
}
