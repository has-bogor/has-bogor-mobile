import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.indigo[900], // Ganti warna AppBar
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'username',
                      hintStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.blueGrey[800], // Menambahkan warna latar belakang
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.blueGrey), // BlueGrey border
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.blueGrey), // BlueGrey focused border
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.blueGrey), // BlueGrey enabled border
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    ),
                    style: const TextStyle(
                      color: Colors.white, // Menambahkan teks warna putih
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.blueGrey[800], // Menambahkan warna latar belakang
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.blueGrey), // BlueGrey border
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.blueGrey), // BlueGrey focused border
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.blueGrey), // BlueGrey enabled border
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    ),
                    obscureText: true,
                    style: const TextStyle(
                      color: Colors.white, // Menambahkan teks warna putih
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm Password',
                      filled: true,
                      hintStyle: const TextStyle(color: Colors.white),
                      fillColor: Colors.blueGrey[800], // Menambahkan warna latar belakang
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.blueGrey), // BlueGrey border
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.blueGrey), // BlueGrey focused border
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        borderSide: BorderSide(color: Colors.blueGrey), // BlueGrey enabled border
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    ),
                    obscureText: true,
                    style: const TextStyle(
                      color: Colors.white, // Menambahkan teks warna putih
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () async {
                      String username = _usernameController.text;
                      String password1 = _passwordController.text;
                      String password2 = _confirmPasswordController.text;

                      // Cek kredensial
                      final response = await request.postJson(
                          "http://127.0.0.1:8000/authentication/api/register/",
                          jsonEncode({
                            "username": username,
                            "password1": password1,
                            "password2": password2,
                          }));

                      if (context.mounted) {
                        // Check if registration is successful
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Successfully registered!'),
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        } else if (response['error'] == 'username already exists') {
                          // Handle case where username is already taken
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Username already exists. Please log in.'),
                            ),
                          );
                          // Optionally, navigate to login page if the user wants to log in
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to register!'),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.indigo[900], // Tombol dengan warna biru
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text('Register'),
                  ),
                  const SizedBox(height: 16.0),
                  // Opsi login jika sudah punya akun
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      'Have an account? Login',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
