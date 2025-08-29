import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do/screens/HomeScreen.dart';
import 'package:to_do/screens/auth/Signup.dart';
import 'package:to_do/screens/todo_screen.dart';
import 'package:to_do/utils/utils.dart';

// The login screen widget
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Key to track the form's state
  final _formKey = GlobalKey<FormState>();
  // Controllers to track text input
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  @override
  // void initState() {
  //   super.initState();
  //   // Listen for text changes to update border color
  //   _emailController.addListener(() {
  //     setState(() {}); // Rebuild UI when email text changes
  //   });
  //   _passwordController.addListener(() {
  //     setState(() {}); // Rebuild UI when password text changes
  //   });
  // }
  @override
  void dispose() {
    // Clean up controllers to avoid memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login() {
    _auth
        .signInWithEmailAndPassword(
          email: _emailController.text.toString(),
          password: _passwordController.text.toString(),
        )
        .then((value) {
          Utils().toastmessage(value.user!.email.toString());
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomeScreen())
          );
    })
        .onError((error, stackTrace) {
          Utils().toastmessage(error.toString());

        });
  }

  @override
  Widget build(BuildContext context) {
    // Define AppBar color for reuse
    const appBarColor = Color(0xFF18442A);
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Login', style: TextStyle(color: Color(0xFFF3EDE3))),
          backgroundColor: appBarColor,
        ),
        backgroundColor: Color(0xFF45644A), // Screen background color
        body: Center(
          child: Container(
            width: 300, // Fixed width for the form container
            padding: EdgeInsets.all(20.0), // Inner padding for the form
            decoration: BoxDecoration(
              color: Color(0xFFE4DBC4), // Container background color
              borderRadius: BorderRadius.circular(10), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3), // Subtle shadow
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // Shadow position
                ),
              ],
            ),
            child: Form(
              key: _formKey, // Connects the form to the key
              child: Column(
                mainAxisSize: MainAxisSize.min, // Shrink-wrap the column
                children: [
                  // Email input field
                  TextFormField(
                    controller: _emailController, // Attach controller
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: appBarColor),
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              _emailController.text.isEmpty
                                  ? Colors
                                      .grey // Default color when empty
                                  : appBarColor, // AppBar color when filled
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              _emailController.text.isEmpty
                                  ? Colors.grey
                                  : appBarColor,
                        ),
                      ),
                    ),
                    // Check if email is valid
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      // Simple email check (contains @ and .)
                      if (!value.contains('@') || !value.contains('.')) {
                        return 'Enter a valid email';
                      }
                      return null; // Return null if valid
                    },
                  ),
                  SizedBox(height: 20), // Space between fields
                  // Password input field
                  TextFormField(
                    controller: _passwordController, // Attach controller
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: appBarColor),
                      prefixIcon: Icon(Icons.lock_open),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              _passwordController.text.isEmpty
                                  ? Colors
                                      .grey // Default color when empty
                                  : appBarColor, // AppBar color when filled
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              _passwordController.text.isEmpty
                                  ? Colors.grey
                                  : appBarColor,
                        ),
                      ),
                    ),
                    obscureText: true, // Hide password text
                    // Check if password is empty
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null; // Return null if valid
                    },
                  ),
                  SizedBox(height: 20), // Space before button
                  // Login button
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: appBarColor, // Button background
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    onPressed: () {
                      // Check if form is valid
                      if (_formKey.currentState!.validate()) {
                        login();
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 16, color: Color(0xFFF3EDE3)),
                    ),
                  ),
                  // Forgot Password text
                  Row(
                    children: [
                      Text("Don't have an account"),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor:
                              Colors.transparent, // Match container
                        ),
                        onPressed: () {
                          // Placeholder action for Forgot Password
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Color(0xFF45644A)),
                        ),
                      ),
                    ],
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
