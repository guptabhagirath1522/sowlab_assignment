import 'dart:io';

import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'https://sowlab.com/assignment/';

  Future<http.Response> login(String email, String password) {
    return http.post(
      Uri.parse('$baseUrl/user/login'),
      body: {'email': email, 'password': password},
    );
  }

  Future<http.Response> register(String name, String email, String password) {
    return http.post(
      Uri.parse('$baseUrl/user/register'),
      body: {'name': name, 'email': email, 'password': password},
    );
  }

  Future<void> uploadProof(File file) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${ApiService.baseUrl}/user/upload-proof'),
    );
    request.files.add(await http.MultipartFile.fromPath('proof', file.path));

    var response = await request.send();
    if (response.statusCode == 200) {
      print('File uploaded successfully');
    } else {
      print('Failed to upload file');
    }
  }

  Future<http.Response> forgotPassword(String mobile) {
    return http.post(
      Uri.parse('$baseUrl/user/forgot-password'),
      body: {'mobile': mobile},
    );
  }

  Future<http.Response> verifyOtp(String otp) {
    return http.post(
      Uri.parse('$baseUrl/user/verify-otp'),
      body: {'otp': otp},
    );
  }

  Future<http.Response> resetPassword(String email, String password) {
    return http.post(
      Uri.parse('$baseUrl/user/reset-password'),
      body: {'email': email, 'password': password},
    );
  }

  Future<http.Response> finalizeConfirmation() {
    return http.post(
      Uri.parse('$baseUrl/user/finalize-confirmation'),
      body: {},
    );
  }
}
