import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:sowlab_assignment/components/custom_appbar.dart';
import 'package:sowlab_assignment/constant/color_constant.dart';
import 'package:sowlab_assignment/constant/font_constant.dart';
import 'package:sowlab_assignment/screens/register/hours.dart';
import 'package:sowlab_assignment/screens/register/verification2.dart';

class Verification2 extends StatelessWidget {
  const Verification2({super.key});

  Future<void> uploadProof(File file) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://yourapi.com/upload-proof'),
    );
    request.files.add(await http.MultipartFile.fromPath('proof', file.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      print('File uploaded successfully');
    } else {
      print('Failed to upload file');
    }
  }

  Future<void> _pickAndUploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      await uploadProof(file);
    } else {
      print('No file selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Text('Signup 3 of 4',
                style: Vit.medium
                    .copyWith(color: const Color(0x4D000000), fontSize: 12)),
            const SizedBox(height: 4),
            Text('Verification', style: Vit.bold.copyWith(fontSize: 24)),
            const SizedBox(height: 24),
            Text(
              'Attach proof of Department of Agriculture registrations i.e. Florida Fresh, USDA Approved, USDA Organic',
              textAlign: TextAlign.justify,
              style: Vit.regular.copyWith(
                color: const Color(0x4D000000),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Text(
                  'Attach proof of registration',
                  style: Vit.regular.copyWith(fontSize: 14, color: primaryText),
                ),
                const Spacer(),
                MaterialButton(
                  onPressed: _pickAndUploadFile,
                  color: primary,
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                  shape: const CircleBorder(),
                  child: const Icon(
                    Icons.photo_camera,
                    size: 24,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 54.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Hours();
                      }));
                    },
                    child: Container(
                      height: 52,
                      width: 226,
                      decoration: const BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
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
            ),
          ],
        ),
      ),
    );
  }
}
