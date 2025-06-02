import 'package:flutter/material.dart';
import 'package:flutter_project/pages/user-page/userloginpage.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 15,),
                Text(
                  'Sign Up',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 26,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  'Welcome. We are waiting for your presence.',
                  style: GoogleFonts.poppins(
                    color: Colors.grey.shade800,
                    fontSize: 13,
                  ),
                ),
                Form(
                  key: _signupFormkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40),
                      Text(
                        ' First Name',
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _firstnametext,
                        validator: (value) {
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15 ),
                          hintText: 'Enter your first name',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 2,
                            ), // Border when enabled
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
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _lastnametext,
                        validator: (value) {
                          return null;
                        },
                      
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15 ),
                          hintText: 'Enter your last name',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 2,
                            ), // Border when enabled
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
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _phonenumber,
                        validator: (value) {
                          return null;
                        },
                         decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15 ),
                        hintText: 'Enter your phone number',
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 2,
                          ), // Border when enabled
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
                        textAlign: TextAlign.left,
                      ),
                      TextFormField(
                        controller: _signupPasswordtext,
                        validator: (value) {
                          return null;
                        },
                         decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 15 ),
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 2,
                            ), // Border when enabled
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
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
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
                const SizedBox(height: 10,),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (builder) => UserLoginpage()),
                      );
                    },
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(0, 2, 10, 4)
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
