import 'package:flutter/material.dart';
import 'package:sowlab_assignment/components/custom_appbar.dart';
import 'package:sowlab_assignment/components/custom_textfield.dart';
import 'package:sowlab_assignment/constant/color_constant.dart';
import 'package:sowlab_assignment/constant/font_constant.dart';
import 'package:sowlab_assignment/screens/register/verification.dart';
import 'package:sowlab_assignment/services/api_services.dart';
import 'dart:convert';

class FarmInfo extends StatefulWidget {
  @override
  _FarmInfoState createState() => _FarmInfoState();
}

class _FarmInfoState extends State<FarmInfo> {
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController informalNameController = TextEditingController();
  final TextEditingController streetAddressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();

  bool isLoading = false;
  final ApiService _apiService = ApiService();

  Future<void> submitFarmInfo() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await _apiService.register(
        businessNameController.text,
        informalNameController.text,
        streetAddressController.text,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Farm Info submitted successfully!')),
        );

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Verification();
        }));
      } else {
        final errorResponse = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Submission failed: ${errorResponse['message']}')),
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
              Text('Signup 2 of 4',
                  style: Vit.medium
                      .copyWith(color: const Color(0x4D000000), fontSize: 12)),
              const SizedBox(height: 4),
              Text('Farm Info', style: Vit.bold.copyWith(fontSize: 24)),
              const SizedBox(height: 40),
              CustomTextField(
                controller: businessNameController,
                icon: Icons.business,
                hintText: 'Business Name',
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: informalNameController,
                icon: Icons.person,
                hintText: 'Informal Name',
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: streetAddressController,
                icon: Icons.location_on,
                hintText: 'Street Address',
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: cityController,
                icon: Icons.location_city,
                hintText: 'City',
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Container(
                    height: 48,
                    width: 126,
                    decoration: const BoxDecoration(
                        color: Color(0xffeeedec),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextField(
                      controller: stateController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'State',
                        hintStyle: Vit.regular.copyWith(
                            fontSize: 14, color: const Color(0x61000000)),
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  Container(
                    height: 48,
                    width: 188,
                    decoration: const BoxDecoration(
                        color: Color(0xffeeedec),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextField(
                      controller: zipCodeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Zipcode',
                        hintStyle: Vit.regular.copyWith(
                            fontSize: 14, color: const Color(0x61000000)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 200),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  InkWell(
                    onTap: isLoading ? null : submitFarmInfo,
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
            ],
          ),
        ),
      ),
    );
  }
}
