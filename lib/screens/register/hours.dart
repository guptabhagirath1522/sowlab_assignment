import 'package:flutter/material.dart';
import 'package:sowlab_assignment/components/custom_appbar.dart';
import 'package:sowlab_assignment/constant/color_constant.dart';
import 'package:sowlab_assignment/constant/font_constant.dart';
import 'package:sowlab_assignment/screens/register/confirmation.dart';
import 'package:sowlab_assignment/services/api_services.dart';

class Hours extends StatefulWidget {
  @override
  _HoursState createState() => _HoursState();
}

class _HoursState extends State<Hours> {
  // Store selected times for each day
  Map<String, List<String>> selectedTimes = {
    'M': ['1:00pm - 4:00pm', '4:00pm - 7:00pm'],
    'T': ['10:00am - 1:00pm', '1:00pm - 4:00pm'],
    'W': ['8:00am - 10:00am', '10:00am - 1:00pm'],
    'Th': ['4:00pm - 7:00pm', '7:00pm - 10:00pm'],
    'F': ['1:00pm - 4:00pm', '4:00pm - 7:00pm'],
    'S': ['8:00am - 10:00am', '7:00pm - 10:00pm'],
    'Su': [],
  };

  // Define available times
  List<String> availableTimes = [
    '8:00am - 10:00am',
    '10:00am - 1:00pm',
    '1:00pm - 4:00pm',
    '4:00pm - 7:00pm',
    '7:00pm - 10:00pm',
  ];

  // Selected day
  String selectedDay = 'W';

  ApiService apiService = ApiService();
  bool isLoading = false;

  // Submit registration data
  Future<void> _submit() async {
    setState(() {
      isLoading = true;
    });

    try {
      String name = 'John Doe'; // Replace with actual values if necessary
      String email = 'john.doe@example.com';
      String password = 'password123';

      final response = await apiService.register(name, email, password);

      if (response.statusCode == 200) {
        print('Registration successful');

        // Navigate to Confirmation Page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Confirmation()),
        );
      } else {
        print('Registration failed: ${response.body}');
        // Optionally handle registration failure
      }
    } catch (e) {
      print('Error occurred: $e');
      // Optionally handle error
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Text('Signup 4 of 4',
                style: Vit.medium
                    .copyWith(color: const Color(0x4D000000), fontSize: 12)),
            const SizedBox(height: 4),
            Text('Business Hours', style: Vit.bold.copyWith(fontSize: 24)),
            const SizedBox(height: 24),
            Text(
              'Choose the hours your farm is open for pickups. This will allow customers to order deliveries.',
              textAlign: TextAlign.justify,
              style: Vit.regular.copyWith(
                color: const Color(0x4D000000),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ['M', 'T', 'W', 'Th', 'F', 'S', 'Su'].map((day) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDay = day;
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color:
                          selectedDay == day ? primary : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      day,
                      style: Vit.bold,
                    ),
                  ),
                );
              }).toList(),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 3,
                ),
                itemCount: availableTimes.length,
                itemBuilder: (context, index) {
                  String time = availableTimes[index];
                  bool isSelected =
                      selectedTimes[selectedDay]?.contains(time) ?? false;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedTimes[selectedDay]?.remove(time);
                        } else {
                          selectedTimes[selectedDay]?.add(time);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? selectedDay == 'W'
                                ? const Color(0xffF8C569)
                                : Colors.grey.shade400
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      alignment: Alignment.center,
                      child: Text(time,
                          style:
                              Vit.regular.copyWith(fontSize: 10, color: black)),
                    ),
                  );
                },
              ),
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
                    onTap: isLoading ? null : _submit,
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
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
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
            ),
          ],
        ),
      ),
    );
  }
}
