import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:sowlab_assignment/components/custom_appbar.dart';
import 'package:sowlab_assignment/constant/color_constant.dart';
import 'package:sowlab_assignment/constant/font_constant.dart';
import 'package:sowlab_assignment/screens/login/login.dart';
import 'package:sowlab_assignment/screens/login/reset_password.dart';
import 'package:sowlab_assignment/services/api_services.dart';

class VerifyOtp extends StatefulWidget {
  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  String _otp = '';

  void _verifyOtp() async {
    if (_otp.isEmpty || _otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 6-digit OTP")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      print("Verifying OTP: $_otp");
      http.Response response = await _apiService.verifyOtp(_otp);

      setState(() {
        _isLoading = false;
      });

      var jsonResponse = json.decode(response.body);

      if (jsonResponse['success'] == 'true' ||
          jsonResponse['message'] == 'OTP cannot be empty.') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ResetPassword()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(jsonResponse['message'] ??
                  'Unable to verify OTP, please try again.')),
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
                    'Verify OTP',
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
                OtpTextField(
                  numberOfFields: 6,
                  borderColor: Colors.transparent,
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {
                    setState(() {
                      _otp = code;
                    });
                  },
                  onSubmit: (String verificationCode) {
                    setState(() {
                      _otp = verificationCode;
                    });
                  },
                ),
                const SizedBox(height: 32),
                _isLoading
                    ? const CircularProgressIndicator()
                    : InkWell(
                        onTap: _verifyOtp,
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
                              'Submit',
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
