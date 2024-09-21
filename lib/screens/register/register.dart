import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sowlab_assignment/components/custom_appbar.dart';
import 'package:sowlab_assignment/components/custom_textfield.dart';
import 'package:sowlab_assignment/constant/font_constant.dart';
import 'package:sowlab_assignment/constant/color_constant.dart';
import 'package:sowlab_assignment/screens/login/login.dart';
import 'package:sowlab_assignment/screens/register/farm_info.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false;

  Future<void> registerUser() async {
    final String apiUrl = "https://sowlab.com/assignment/user/register";

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match!')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": fullNameController.text,
          "email": emailController.text,
          "phone": phoneController.text,
          "password": passwordController.text,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration successful!')),
        );

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FarmInfo();
        }));
      } else {
        final errorResponse = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Registration failed: ${errorResponse['message']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Text('Signup 1 of 4',
                  style: Vit.medium
                      .copyWith(color: const Color(0x4D000000), fontSize: 12)),
              const SizedBox(height: 4),
              Text('Welcome!', style: Vit.bold.copyWith(fontSize: 24)),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSocialButton(
                    'assets/images/google_logo.png',
                    onPressed: () {},
                  ),
                  _buildSocialButton(
                    'assets/images/apple_logo.png',
                    onPressed: () {},
                  ),
                  _buildSocialButton(
                    'assets/images/facebook_logo.png',
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Center(
                  child: Text('or signup with',
                      style: Vit.medium
                          .copyWith(fontSize: 10, color: Color(0x4d261C12)))),
              const SizedBox(height: 32),
              CustomTextField(
                controller: fullNameController,
                icon: Icons.person,
                hintText: 'Full Name',
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: emailController,
                icon: Icons.alternate_email,
                hintText: 'Email Address',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: phoneController,
                icon: Icons.call,
                hintText: 'Phone Number',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: passwordController,
                icon: Icons.lock_outline,
                hintText: 'Password',
                isPassword: true,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: confirmPasswordController,
                icon: Icons.lock_outline,
                hintText: 'Re-enter Password',
                isPassword: true,
              ),
              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginScreen();
                      }));
                    },
                    child: Text('Login',
                        style: Vit.medium.copyWith(
                            color: black,
                            decoration: TextDecoration.underline)),
                  ),
                  InkWell(
                    onTap: isLoading ? null : registerUser,
                    child: Container(
                      height: 52,
                      width: 226,
                      decoration: BoxDecoration(
                        color: isLoading ? Colors.grey : primary,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: isLoading
                            ? CircularProgressIndicator(color: white)
                            : Text(
                                'Continue',
                                style: Vit.medium
                                    .copyWith(fontSize: 18, color: white),
                              ),
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

Widget _buildSocialButton(String iconPath, {required VoidCallback onPressed}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: 52,
      width: 96,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        border: Border.all(color: const Color(0x14000000), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.asset(iconPath),
      ),
    ),
  );
}
