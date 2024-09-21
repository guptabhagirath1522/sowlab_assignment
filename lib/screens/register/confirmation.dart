import 'package:flutter/material.dart';
import 'package:sowlab_assignment/constant/color_constant.dart';
import 'package:sowlab_assignment/constant/font_constant.dart';
import 'package:sowlab_assignment/screens/homescreen/homescreen.dart';
import 'package:sowlab_assignment/services/api_services.dart';

class Confirmation extends StatelessWidget {
  Confirmation({super.key});

  final ApiService apiService = ApiService();

  Future<void> _finalizeConfirmation(BuildContext context) async {
    try {
      final response = await apiService.finalizeConfirmation();

      if (response.statusCode == 200) {
        print('Confirmation successful');
      } else {
        print('Confirmation failed: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MyHomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Center(child: Image.asset('assets/images/Vector@1x.png')),
              const SizedBox(
                height: 36,
              ),
              Text(
                'You’re all done!',
                style: Vit.bold.copyWith(color: primaryText, fontSize: 32),
              ),
              const SizedBox(height: 24),
              Text(
                "Hang tight! We are currently reviewing your account and will follow up with you in 2-3 business days. In the meantime, you can setup your inventory.",
                textAlign: TextAlign.center,
                style: Vit.regular.copyWith(color: const Color(0xff898989)),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 54.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage()),
                    );
                  },
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
                        'Got it!',
                        style: Vit.medium.copyWith(
                          fontSize: 18,
                          color: white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
