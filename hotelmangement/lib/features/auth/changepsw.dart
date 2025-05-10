import 'package:flutter/material.dart';
import 'package:hotelmangement/features/auth/forgotpsw.dart';
import 'package:hotelmangement/features/auth/login.dart';

void main() {
  runApp(MaterialApp(
    home: ChangeScreen(),
  ));
}

class ChangeScreen extends StatefulWidget {
  const ChangeScreen({super.key});

  @override
  State<ChangeScreen> createState() => _ChangeScreenState();
}

class _ChangeScreenState extends State<ChangeScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

//-----------------------success popup box---------------------------------
  void _showSuccessPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Password Changed Successfully",
            textAlign: TextAlign.center,
            style: TextStyle(color: Color.fromARGB(255, 88, 3, 4)),
          ),
          content: const Text(
            "Your password has been updated successfully! Please log in again.",
            textAlign: TextAlign.center,
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text(
                  "OK",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromARGB(255, 88, 3, 4),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

//--------------------------------error popup box--------------------------------
  void _showErrorPopup(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Error",
            textAlign: TextAlign.center,
            style: TextStyle(color: Color.fromARGB(255, 88, 3, 4)),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); 
                },
                child: const Text(
                  "OK",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromARGB(255, 88, 3, 4),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //-------------------------app bar-------------------------------
     appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 88, 3, 4),
        leading: BackButton(
          color: Color.fromARGB(255, 255, 255, 255),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ForgotScreen()), // Navigate to MainScreen
            );
          },
        ),
      ),

      //--------------------------body----------------------------------
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
             boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 88, 3, 4),
                blurRadius: 5,
                spreadRadius: 1,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(
              color: const Color.fromARGB(255, 88, 3, 4),
              width: 1.5,
            ),
            ),

            //--------------------title----------------------------------------
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text(
                    "Change Password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 88, 3, 4),
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                //---------------------new password----------------------
                _buildPasswordField(_passwordController, "New Password"),

                const SizedBox(height: 10),

                //-------------------confirm password------------------------------
                _buildPasswordField(_confirmPasswordController, "Confirm Password"),

                const SizedBox(height: 30),

                //------------------------validation------------------------------
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      final password = _passwordController.text.trim();
                      final confirmPassword = _confirmPasswordController.text.trim();


                      if (password.isEmpty || confirmPassword.isEmpty) {
                        _showErrorPopup("Please fill out all fields.");
                      } else if (password != confirmPassword) {
                        _showErrorPopup("Passwords do not match.");
                      } else {
                        _showSuccessPopup();
                      }
                    },


                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 88, 3, 4),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),

                    //---------------------------update button---------------------------
                    child: const Text(
                      "Update",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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

  Widget _buildPasswordField(TextEditingController controller, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: TextField(
        controller: controller,
        obscureText: true,
        style: const TextStyle(fontSize: 18, height: 1),
        keyboardType: TextInputType.visiblePassword,
        
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 18),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color.fromARGB(255, 88, 3, 4), width: 3),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Color.fromARGB(255, 88, 3, 4), width: 2),
          ),
        ),
      ),
    );
  }
}