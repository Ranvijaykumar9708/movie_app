import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:movie_app/profile/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  File? _profileImage;

  // Function to pick an image from the gallery or camera
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery); // You can use .camera for taking a photo
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Image Section
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[200],
                backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                child: _profileImage == null
                    ? Icon(Icons.add_a_photo, color: Colors.blueAccent, size: 40)
                    : null,
              ),
            ),
            SizedBox(height: 16),
            // Email input field with decoration
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.blueAccent),
                prefixIcon: Icon(Icons.email, color: Colors.blueAccent),
                hintText: 'Enter your email address',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            // Password input field with decoration
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.blueAccent),
                prefixIcon: Icon(Icons.lock, color: Colors.blueAccent),
                hintText: 'Enter your password',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            // Confirm Password input field with decoration
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                labelStyle: TextStyle(color: Colors.blueAccent),
                prefixIcon: Icon(Icons.lock, color: Colors.blueAccent),
                hintText: 'Re-enter your password',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            // SignUp Button
            ElevatedButton(
              onPressed: () {
                // Handle sign-up action here
                String email = _emailController.text;
                String password = _passwordController.text;
                String confirmPassword = _confirmPasswordController.text;

                if (password == confirmPassword) {
                  // Implement your sign-up logic
                  if (kDebugMode) {
                    print('Email: $email, Password: $password');
                  }
                  // After successful sign-up, navigate to the home page or login
                  Navigator.pop(context); // Or navigate to another screen
                } else {
                  // Show error message if passwords do not match
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Passwords do not match!")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Sign Up'),
            ),
            SizedBox(height: 16),
            // Navigate to Login Page
            TextButton(
              onPressed: () {
                // Navigate to the Login page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
