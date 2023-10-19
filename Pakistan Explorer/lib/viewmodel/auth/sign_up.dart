import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:travelhour/view/bottom/bottomnigation.dart';
import 'package:travelhour/viewmodel/auth/login_screen.dart';
import 'package:travelhour/utils/utilities.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool loadding = false;
  bool isCheck = true;
  bool isCheck2 = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firstNameController.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _firstNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!isValidEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: isCheck,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          isCheck = !isCheck;
                          setState(() {});
                        },
                        icon: isCheck
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      )),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: isCheck2,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isCheck2 = !isCheck2;
                        });
                      },
                      icon: isCheck2
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loadding = true;
                        });
                        // Validation succeeded, perform sign-up operation

                        String firstName = _firstNameController.text;

                        String email = _emailController.text.toString();
                        String password = _passwordController.text.toString();
                        performSignUp(firstName, email, password);

                        auth
                            .createUserWithEmailAndPassword(
                          email: email.toString(),
                          password: password.toString(),
                        )
                            .then((value) {
                          Utils().toastMessage("Account created Successfully!");
                          setState(() {
                            loadding = false;
                          });
                          ref
                              .child(value.user!.uid.toString())
                              .set({
                                'uid': value.user!.uid.toString(),
                                'firstname': firstName,
                                'email': email,
                                'profile': '',
                                'onlinestatus': 'noOne',
                              })
                              .then((value) {})
                              .onError((error, stackTrace) {
                                Utils().toastMessage(
                                  error.toString(),
                                );
                              });
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return BottomNavigationClass();
                              },
                            ),
                          );
                        }).onError((error, stackTrace) {
                          Utils().toastMessage(
                            error.toString(),
                          );
                          setState(() {
                            loadding = false;
                          });
                        });
                      }
                    },
                    child: loadding
                        ? const CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          )
                        : const Text('Sign Up'),
                  ),
                ),
                const SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account ?'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return const LoginScreen();
                            }),
                          );
                        },
                        child: const Text('Login'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    // Use a regular expression or any other email validation technique
    // to validate the email format
    // For example:
    return RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(email);
  }

  void performSignUp(String firstName, String email, String password) {
    // You can call an API, store the user information, etc.
    // For simplicity, we'll just print the user information here

    debugPrint('First Name: $firstName');

    debugPrint('Email: $email');
    debugPrint('Password: $password');
  }
}
