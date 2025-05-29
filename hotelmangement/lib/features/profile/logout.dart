import 'package:flutter/material.dart';
import 'package:hotelmangement/features/auth/home.dart';
import 'package:hotelmangement/features/auth/login.dart';


class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      //-----------------------app bar---------------
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 88, 3, 4),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
        ),
      ),

      //--------------------body----------------------
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
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

          //------------------image------------------------
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/profile/logout.png",
                height: 200,
                scale: 1,
              ),
          
          //--------------------title---------------------
              const SizedBox(height: 10),
              const Text(
                "Comeback Soon!",
                style: TextStyle(
                  color: Color.fromARGB(255, 88, 3, 4),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
          
              const SizedBox(height: 10),
          //--------------------description-------------------
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Are you sure you want to logout?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 88, 3, 4),
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
              ),

              const SizedBox(height: 40),
            //-------------------buttons----------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  //--------------------cancel button---------------------
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                          color: Color.fromARGB(255, 88, 3, 4), width: 2),
                      elevation: 4,
                      minimumSize: const Size(150, 50),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 88, 3, 4),
                      ),
                    ),
                  ),

                  //-------------------logout button------------------------
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 88, 3, 4),
                      elevation: 4,
                      minimumSize: const Size(150, 50),
                    ),
                    child: const Text(
                      "Yes, Logout",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}