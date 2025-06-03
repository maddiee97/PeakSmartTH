import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/screens/selection/provider_selection_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String _message = '';
  String _passwordError = '';

  bool _isPasswordValid(String password) {
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');
    return regex.hasMatch(password);
  }

  Future<void> _register() async {
    setState(() {
      _passwordError = '';
      _message = '';
    });

    if (!_isPasswordValid(_passwordController.text)) {
      setState(() {
        _passwordError =
            'Must contain at least 1 uppercase, 1 lowercase and 1 numeric character. Minimum 8 characters';
      });
      return;
    }

    if (_passwordController.text != _confirmPassController.text) {
      setState(() {
        _message = 'Passwords do not match.';
      });
      return;
    }

    try {
      final res = await http.post(
        Uri.parse(
            'https://peaksmartth-production.up.railway.app/api/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': _usernameController.text.trim(),
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
        }),
      );

      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');

      if (res.statusCode == 201) {
        final responseData = json.decode(res.body);
        final userId = responseData['userId'];

        if (userId != null) {
          if (!mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProviderSelectionScreen(
                username: _usernameController.text.trim(),
                email: _emailController.text.trim(),
                userId: userId,
              ),
            ),
          );
        } else {
          setState(() {
            _message = 'Registration failed: No user ID returned';
          });
        }
      } else {
        setState(() {
          _message = 'Registration failed: ${res.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'An error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext ctx) {
    final bottomInset = MediaQuery.of(ctx).viewInsets.bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F0),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: Color(0xFF366D34),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Register to get started!',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 24),

                // Username
                TextField(
                  controller: _usernameController,
                  style: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF8391A1),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle: const TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF8391A1),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF7F8F9),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE8ECF4)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: Color(0xFFE8ECF4), width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Email
                TextField(
                  controller: _emailController,
                  style: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF8391A1),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: const TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF8391A1),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF7F8F9),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE8ECF4)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: Color(0xFFE8ECF4), width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Password
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF8391A1),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF8391A1),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF7F8F9),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE8ECF4)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: Color(0xFFE8ECF4), width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Confirm Password
                TextField(
                  controller: _confirmPassController,
                  obscureText: _obscureConfirmPassword,
                  style: const TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF8391A1),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Confirm password',
                    hintStyle: const TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF8391A1),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () => setState(() =>
                          _obscureConfirmPassword = !_obscureConfirmPassword),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF7F8F9),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE8ECF4)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: Color(0xFFE8ECF4), width: 1.5),
                    ),
                  ),
                ),

                if (_passwordError.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      _passwordError,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Color(0xFFFF0000),
                      ),
                    ),
                  ),

                if (_message.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      _message,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                  ),

                const SizedBox(height: 24),

                // Register Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF366D34),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Or Register with',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 16),

                Center(
                  child: Container(
                    width: 331,
                    height: 47,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 4)
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/icons/Google.png',
                        height: 30,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        style: const TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade800,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
