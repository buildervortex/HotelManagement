import 'package:flutter/material.dart';
import 'package:hotelmangement/features/auth/login.dart';
import 'package:hotelmangement/features/auth/register.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      //---------------------app bar---------------------------
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 88, 3, 4),
      ),

      //--------------------------body--------------------------
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        //--------------------------image----------------------
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/auth/welcome.png",
                height: 300,
                scale: 2,
              ),
            ),

            const SizedBox(height: 20),

            //-------------------title----------------------------
            const Text(
              "Welcome to the app!",
              style: TextStyle(
                color: Color.fromARGB(255, 88, 3, 4),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            //---------------------description--------------------
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Book one of our unique hotels to escape the ordinary",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 88, 3, 4),
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
              ),
            ),

            const SizedBox(height: 100),

            //---------------------------------login button---------------------------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 88, 3, 4),
                  elevation: 4,
                  minimumSize: const Size(500, 50),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            //------------------------create account button------------------------------
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(
                      color: Color.fromARGB(255, 88, 3, 4), width: 2),
                  elevation: 4,
                  minimumSize: const Size(500, 50),
                ),
                child: const Text(
                  "Create Account",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 88, 3, 4),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
