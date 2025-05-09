import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hotelmangement/features/auth/auth.dart';
import 'package:hotelmangement/features/auth/forgotpsw.dart';
import 'package:hotelmangement/features/auth/home.dart';
import 'package:hotelmangement/features/auth/register.dart';

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;

  void _onChecked(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 88, 3, 4),
        leading: BackButton(
          color: Color.fromARGB(255, 255, 255, 255),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AuthScreen()), // Navigate to MainScreen
            );
          },
        ),
      ),

      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Welcome back, glad to see you!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 88, 3, 4)),
                  ),
                ),

                SizedBox(height: 30),

                // Email Field
                _buildTextField(
                  controller: _emailController,
                  hintText: "Enter your email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),

                // Password Field
                _buildTextField(
                  controller: _passwordController,
                  hintText: "Enter your password",
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),

                // Remember Me & Forgot Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: _onChecked,
                          activeColor: Color.fromARGB(255, 88, 3, 4),
                        ),
                        Text("Remember Me", style: TextStyle(fontSize: 16,color: Color.fromARGB(255, 88, 3, 4))),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgotScreen()),
                        );
                      },
                      child: Text("Forgot Password?", style: TextStyle(color: Color.fromARGB(255, 88, 3, 4))),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Login Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 88, 3, 4),
                      side: BorderSide(color: Color.fromARGB(255, 88, 3, 4), width: 2),
                      elevation: 4,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // OR Divider
                 Row(
                  children: [
                    Expanded(child: Divider(color: Color.fromARGB(255, 88, 3, 4), height: 36)),
                    Text(" OR " ,style: TextStyle(
                color: Color.fromARGB(255, 88, 3, 4))),
                    Expanded(child: Divider(color: Color.fromARGB(255, 88, 3, 4), height: 36)),
                  ],
                ),

                SizedBox(height: 10),

                // Login with Google Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Color.fromARGB(255, 88, 3, 4), width: 2),
                      elevation: 4,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Center(
                      child: Text(
                        "Sign in with Google",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 88, 3, 4)),
                      ),
                    ),
                  ),
                ),

                // Sign Up Text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(fontSize: 16, color:Color.fromARGB(255, 88, 3, 4)),
                      children: [
                        TextSpan(
                          text: "Sign up here",
                          style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 88, 3, 4), decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                            },
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: 18, height: 1),
        obscureText: obscureText,
        decoration: _inputDecoration(hintText),
        validator: validator,
      ),
    );
  }

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(fontSize: 18),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Color.fromARGB(255, 88, 3, 4), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Color.fromARGB(255, 88, 3, 4), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Color.fromARGB(255, 88, 3, 4), width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color:Color.fromARGB(255, 88, 3, 4), width: 2),
      ),
    );
  }
}
