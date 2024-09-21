import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sowlab_assignment/components/custom_appbar.dart';
import 'package:sowlab_assignment/components/custom_textfield.dart';
import 'package:sowlab_assignment/constant/color_constant.dart';
import 'package:sowlab_assignment/constant/font_constant.dart';
import 'package:sowlab_assignment/screens/login/login.dart';
import 'package:sowlab_assignment/screens/login/verify_Otp.dart';
import 'package:sowlab_assignment/services/api_services.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _mobileController = TextEditingController();
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  void _verifyMobile() async {
    final String mobile = _mobileController.text;

    if (mobile.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your mobile number')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      http.Response response = await _apiService.forgotPassword(mobile);

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(jsonResponse['message'] ??
                  'Mobile number verified successfully!')),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyOtp(),
          ),
        );
      } else {
        var jsonResponse = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  jsonResponse['error'] ?? 'Failed to verify mobile number')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('An error occurred. Please try again later.')),
      );
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
                    'Forgot Password?',
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
                  controller: _mobileController,
                  icon: Icons.call,
                  hintText: 'Phone Number',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 32),
                InkWell(
                  onTap: _isLoading ? null : _verifyMobile,
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
                              'Send Code',
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
