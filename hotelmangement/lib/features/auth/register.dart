import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelmangement/core/cubit/auth_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hotelmangement/features/auth/auth.dart';
import 'package:hotelmangement/features/auth/login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final List<String> roles = ["Guest", "Hotel Manager"];
  String? selectedValue;
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    setState(() => _isLoading = true);
    final supabase = Supabase.instance.client;
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final username = _usernameController.text.trim();
    final phone = _phoneController.text.trim();
    final role = selectedValue;

    final isManager = selectedValue == "Hotel Manager";

    if (isManager) {
      BlocProvider.of<AuthCubit>(context)
          .singUpManager(email, password, username, phone);
    } else {
      BlocProvider.of<AuthCubit>(context)
          .singUpUser(email, password, username, phone);
    }

    // try {
    //   // Register with Supabase Auth
    //   final response = await supabase.auth.signUp(
    //     email: email,
    //     password: password,
    //   );
    //   final user = response.user;
    //   if (user == null) throw Exception("Registration failed. Try again!");

    //   // Insert into profiles table
    //   await supabase.from('profiles').insert({
    //     'id': user.id,
    //     'first_name': firstName,
    //     'last_name': lastName,
    //     'username': username,
    //     'phone': phone,
    //     'role': role,
    //   });

    //   // Navigate to Login screen
    //   if (mounted) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Registration successful! Please login.')),
    //     );
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => LoginScreen()),
    //     );
    //   }
    // } on AuthException catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text(e.message)),
    //   );
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Registration failed: $e')),
    //   );
    // } finally {
    //   if (mounted) setState(() => _isLoading = false);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 88, 3, 4),
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AuthScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Center(
                  child: Text(
                    "Welcome! Create your new account",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 88, 3, 4)),
                  ),
                ),
                SizedBox(height: 30),

                // First Name
                _buildTextField(
                  controller: _firstNameController,
                  hintText: "Enter your first name",
                  validator: (value) =>
                      value!.isEmpty ? "First name is required" : null,
                ),

                // Last Name
                _buildTextField(
                  controller: _lastNameController,
                  hintText: "Enter your last name",
                  validator: (value) =>
                      value!.isEmpty ? "Last name is required" : null,
                ),

                // Email
                _buildTextField(
                  controller: _emailController,
                  hintText: "Enter your email address",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) return "Email is required";
                    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),

                // Username
                _buildTextField(
                  controller: _usernameController,
                  hintText: "Enter your username",
                  validator: (value) =>
                      value!.isEmpty ? "Username is required" : null,
                ),

                // Password
                _buildTextField(
                  controller: _passwordController,
                  hintText: "Enter your password",
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) return "Password is required";
                    if (value.length < 6)
                      return "Password must be at least 6 characters";
                    return null;
                  },
                ),

                // Confirm Password
                _buildTextField(
                  controller: _confirmPasswordController,
                  hintText: "Confirm your password",
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) return "Please confirm your password";
                    if (value != _passwordController.text)
                      return "Passwords do not match";
                    return null;
                  },
                ),

                // Phone Number
                _buildTextField(
                  controller: _phoneController,
                  hintText: "Enter your phone number",
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) return "Phone number is required";
                    if (!RegExp(r'^\d{10,15}$').hasMatch(value))
                      return "Enter a valid phone number";
                    return null;
                  },
                ),

                // Select Role
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: DropdownButtonFormField<String>(
                    decoration: _inputDecoration("Select Role"),
                    value: selectedValue,
                    items: roles.map((String role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(role, style: TextStyle(fontSize: 18)),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                    validator: (value) =>
                        value == null ? "Please select a role" : null,
                  ),
                ),

                SizedBox(height: 40),

                // Create Account Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: OutlinedButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              _registerUser();
                            }
                          },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 88, 3, 4),
                      side: BorderSide(
                          color: Color.fromARGB(255, 88, 3, 4), width: 2),
                      elevation: 4,
                      minimumSize: Size(500, 50),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Create Account",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                  ),
                ),

                SizedBox(height: 20),

                // OR Divider
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                            color: Color.fromARGB(255, 88, 3, 4), height: 36)),
                    Text(" OR ",
                        style: TextStyle(color: Color.fromARGB(255, 88, 3, 4))),
                    Expanded(
                        child: Divider(
                            color: Color.fromARGB(255, 88, 3, 4), height: 36)),
                  ],
                ),

                SizedBox(height: 10),

                // Sign Up with Google Button (not implemented)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Google sign up not implemented')),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(
                          color: Color.fromARGB(255, 88, 3, 4), width: 2),
                      elevation: 4,
                      minimumSize: Size(500, 50),
                    ),
                    child: Text(
                      "Sign up with Google",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 88, 3, 4)),
                    ),
                  ),
                ),

                // Login Here Text
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                          fontSize: 16, color: Color.fromARGB(255, 88, 3, 4)),
                      children: [
                        TextSpan(
                          text: "Login here",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 88, 3, 4),
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
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
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: TextStyle(fontSize: 18, height: 1.2),
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
        borderSide:
            BorderSide(color: Color.fromARGB(255, 88, 3, 4), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Color.fromARGB(255, 88, 3, 4), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide:
            BorderSide(color: Color.fromARGB(255, 88, 3, 4), width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Color.fromARGB(255, 88, 3, 4), width: 2),
      ),
    );
  }
}
