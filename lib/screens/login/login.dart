import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sowlab_assignment/components/custom_appbar.dart';
import 'package:sowlab_assignment/components/custom_textfield.dart';
import 'package:sowlab_assignment/constant/color_constant.dart';
import 'package:sowlab_assignment/constant/font_constant.dart';
import 'package:sowlab_assignment/screens/homescreen/homescreen.dart';
import 'package:sowlab_assignment/screens/login/forgot_password.dart';
import 'package:sowlab_assignment/screens/register/register.dart';
import 'package:sowlab_assignment/services/api_services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService apiService = ApiService();

  void _login() async {
    final response = await apiService.login(
      emailController.text,
      passwordController.text,
    );
    print("Response: ${response.statusCode}");
    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 60),
                        Text(
                          'Welcome back!',
                          style: Vit.bold.copyWith(fontSize: 24),
                        ),
                        const SizedBox(height: 16),
                        Text.rich(
                          TextSpan(
                            text: 'New here? ',
                            style: Vit.medium.copyWith(
                                color: const Color(0xffb3b3b3), fontSize: 10),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Create Account',
                                style: Vit.medium
                                    .copyWith(color: primary, fontSize: 10),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigate to the registration page
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrationPage()),
                                    );
                                  },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 72),
                        CustomTextField(
                          controller: emailController,
                          icon: Icons.alternate_email,
                          hintText: 'Email Address',
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: passwordController,
                          icon: Icons.lock_outline,
                          hintText: 'Password',
                          isPassword: true,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPassword(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8),
                              child: Text(
                                'Forgot?',
                                style: Vit.regular
                                    .copyWith(color: primary, fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        InkWell(
                          onTap: _login,
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
                              child: Text(
                                'Login',
                                style: Vit.medium.copyWith(
                                  fontSize: 18,
                                  color: white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'or login with',
                            style: Vit.regular.copyWith(
                              color: const Color(0x4D231C12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildSocialButton(
                              'assets/images/google_logo.png',
                              onPressed: () {
                                print('Google sign-in pressed');
                              },
                            ),
                            _buildSocialButton(
                              'assets/images/apple_logo.png',
                              onPressed: () {
                                print('Apple sign-in pressed');
                              },
                            ),
                            _buildSocialButton(
                              'assets/images/facebook_logo.png',
                              onPressed: () {
                                print('Facebook sign-in pressed');
                              },
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSocialButton(String iconPath,
      {required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 52,
        width: 96,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(iconPath),
        ),
      ),
    );
  }
}
