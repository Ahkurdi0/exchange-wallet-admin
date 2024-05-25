import 'dart:ffi';
import 'dart:ui';

// import 'package:exchange_app_admin/pages/dashbord.dart';
import 'package:exchange_app_admin/models/UserModel.dart';
import 'package:exchange_app_admin/pages/login.dart';
import 'package:exchange_app_admin/services/auth_service.dart';
import 'package:exchange_app_admin/utils/appvalidator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();

  final _lastNameController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneController = TextEditingController();

  final _passwordController = TextEditingController();

  var authService = AuthService();
  var isLoader = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });

      UserModel user = UserModel(
          email: _emailController.text,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          password: _passwordController.value.text,
          phone: _phoneController.value.text);
      await authService.createUser(user, context);

      setState(() {
        isLoader = false;
      });

      // if (success) {

      // }
    }
  }

  var appValidator = AppValidator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF5FF),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Create new Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Color(0xFF0B59D7),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                    controller: _firstNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration:
                        _buildInputDecoration('First Name', Icons.person),
                    validator: appValidator.validateFirstName),
                const SizedBox(height: 16),
                TextFormField(
                    controller: _lastNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration:
                        _buildInputDecoration('Last Name', Icons.person),
                    validator: appValidator.validateLastName),
                const SizedBox(height: 16),
                TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: _buildInputDecoration('Email', Icons.email),
                    validator: appValidator.validateEmail),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: _buildInputDecoration('Phone Number', Icons.phone,
                      prefixText: '07'),
                  validator: (value) {
                    RegExp regExp = RegExp(r'^[0-9]{9}$');
                    if (value?.isEmpty ?? true) {
                      return "Please enter phone number! 07********";
                    } else if (!regExp.hasMatch(value!)) {
                      return "Please enter 9 digits for your phone number!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: _buildInputDecoration('Password', Icons.lock),
                    validator: appValidator.validatePassword),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      isLoader ? print("Loading") : _submitForm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0B59D7),
                    ),
                    child: isLoader
                        ? const Center(child: CircularProgressIndicator())
                        : const Text(
                            'Create Account',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: const Text(
                    'Login ',
                    style: TextStyle(color: Color(0xFF0B59D7), fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String labelText, IconData suffixIcon,
      {String? prefixText}) {
    return InputDecoration(
      prefixText: prefixText,
      fillColor: Colors.white, // Set the fill color to white
      filled: true, // Enable the fillColor to take effect
      labelText: labelText,
      labelStyle: const TextStyle(color: Color.fromARGB(255, 94, 94, 94)),
      suffixIcon: Icon(suffixIcon,
          color: const Color(0xFF0B59D7)), // Icon color remains the same
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide:
            BorderSide.none, // Remove the border color by setting it to none
      ),
    );
  }
}
