import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sowlab_assignment/components/custom_appbar.dart';
import 'package:sowlab_assignment/components/custom_textfield.dart';
import 'package:sowlab_assignment/constant/color_constant.dart';
import 'package:sowlab_assignment/constant/font_constant.dart';
import 'package:sowlab_assignment/screens/login/login.dart';
import 'package:sowlab_assignment/services/api_services.dart';
import 'dart:convert';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpasswordController = TextEditingController();
  final ApiService apiService = ApiService();
  bool _isLoading = false;

  void _resetPassword() async {
    if (passwordController.text.isEmpty || cpasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a password in both fields")),
      );
      return;
    }

    if (passwordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Password must be at least 8 characters long")),
      );
      return;
    }

    if (passwordController.text != cpasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await apiService.resetPassword(
        'johndoe@mail.com',
        passwordController.text,
      );

      if (response.statusCode == 200) {
        jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password reset successful")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        final responseData = jsonDecode(response.body);
        String errorMessage = responseData['error'] ?? 'Password reset failed';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const SizedBox(height: 60),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Reset Password',
                    style: Vit.bold.copyWith(fontSize: 24),
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text.rich(
                    TextSpan(
                      text: 'Remember your password? ',
                      style: Vit.medium.copyWith(
                          color: const Color(0xffb3b3b3), fontSize: 10),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Login',
                          style:
                              Vit.medium.copyWith(color: primary, fontSize: 10),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 72),
                CustomTextField(
                  controller: passwordController,
                  icon: Icons.lock,
                  hintText: 'New Password',
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: cpasswordController,
                  icon: Icons.lock,
                  hintText: 'Confirm Password',
                  isPassword: true,
                ),
                const SizedBox(height: 32),
                InkWell(
                  onTap: _isLoading ? null : _resetPassword,
                  child: Container(
                    height: 52,
                    width: 330,
                    decoration: const BoxDecoration(
                      color: primary,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
                              'Reset Password',
                              style: Vit.medium.copyWith(
                                fontSize: 18,
                                color: white,
                              ),
                            ),
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
}
