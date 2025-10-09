import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/pages/user-page/userloginpage.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:http/http.dart" as http;

class UserSignUppage extends StatefulWidget {
  const UserSignUppage({super.key});

  @override
  State<UserSignUppage> createState() => _UserSignUppageState();
}

class _UserSignUppageState extends State<UserSignUppage> {
  final GlobalKey<FormState> _signupFormkey = GlobalKey<FormState>();
  final TextEditingController _firstnametext = TextEditingController();
  final TextEditingController _lastnametext = TextEditingController();
  final TextEditingController _phonenumber = TextEditingController();
  final TextEditingController _signupPasswordtext = TextEditingController();
  bool isChecked = false;

  bool isUser = true;
  bool isMerchant = false;
  bool isDeliver = false;

  Future<void> createUser() async {
    if (!isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Please allow location access"),
        ),
      );
      return;
    }

    String urlString = "";
    if (isUser) {
      urlString = "http://192.168.1.15:5000/api/users/signup";
    } else if (isDeliver) {
      urlString = "http://192.168.1.15:5000/api/deliver/signup";
    } else if (isMerchant) {
      urlString = "http://192.168.1.15:5000/api/merchant/signup";
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Please select an account type"),
        ),
      );
      return;
    }

    final url = Uri.parse(urlString);
    final userBody = {
      "firstname": _firstnametext.text,
      "lastname": _lastnametext.text,
      "phone_no": _phonenumber.text,
      'password': _signupPasswordtext.text,
      "address": {"latitude": 9.0543, "longitude": 38.095},
    };

    try {
      final responses = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(userBody),
      );
      if (responses.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Text("Sign up successful"),
          ),
        );
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (builder) => UserLoginpage()));
      } else if (responses.statusCode == 409) {
        var errorMessage = jsonDecode(responses.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(errorMessage['error'] ?? "Sign up failed"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text("Sign up failed: ${responses.statusCode}"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text('Error: $e')),
      );
    }
  }

  void _selectAccountType(String type) {
    setState(() {
      isUser = type == 'user';
      isMerchant = type == 'merchant';
      isDeliver = type == 'deliver';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 15),
                Text(
                  'Create an Account',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 26,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () => _selectAccountType('user'),
                        child: Container(
                         
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isUser ? Colors.white : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "User",
                            style: TextStyle(
                              color: isUser ? Colors.blue : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _selectAccountType('deliver'),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color:
                                isDeliver ? Colors.white : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Delivery",
                            style: TextStyle(
                              color: isDeliver ? Colors.blue : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _selectAccountType('merchant'),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color:
                                isMerchant
                                    ? Colors.white
                                    : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Merchant",
                            style: TextStyle(
                              color: isMerchant ? Colors.blue : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                const Text("Select account type"),
                const SizedBox(height: 5),
                Form(
                  key: _signupFormkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        'First Name',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _firstnametext,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                            return 'Please enter a valid last name (only letters and spaces)';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 15,
                          ),
                          hintText: 'Enter your first name',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.green.shade500,
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        'Last Name',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _lastnametext,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                            return 'Please enter a valid last name (only letters and spaces)';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 15,
                          ),
                          hintText: 'Enter your last name',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.green.shade500,
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        'Phone Number',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _phonenumber,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }

                          if (!RegExp(r'^(09|\+2519)\d{8}$').hasMatch(value)) {
                            return 'Please enter a valid Ethiopian phone number (e.g., 09XXXXXXXX or +2519XXXXXXXX)';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 15,
                          ),
                          hintText: 'Enter your phone number',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.green.shade500,
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 25),
                      Text(
                        'Password',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      TextFormField(
                        controller: _signupPasswordtext,
                         validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters long';
                          }
                          if (!value.contains(RegExp(r'[A-Z]'))) {
                            return 'Password must contain at least one uppercase letter';
                          }
                          if (!value.contains(RegExp(r'[a-z]'))) {
                            return 'Password must contain at least one lowercase letter';
                          }
                          if (!value.contains(RegExp(r'[0-9]'))) {
                            return 'Password must contain at least one digit';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.visibility),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 15,
                          ),
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.green.shade500,
                              width: 2,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        obscureText: true,
                        
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (bool? newValue) {
                              setState(() {
                                isChecked = newValue!;
                              });
                            },
                          ),
                          Text(
                            'Allow location access',
                            style: GoogleFonts.poppins(fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      FractionallySizedBox(
                        widthFactor: 0.98,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_signupFormkey.currentState!.validate()) {
                              createUser();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 25,
                            ),
                            backgroundColor: Colors.green.shade700,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Sign up',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (builder) => const UserLoginpage(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(0, 2, 10, 4),
                      ),
                      child: Text(
                        'Log In',
                        style: GoogleFonts.poppins(
                          color: Colors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
