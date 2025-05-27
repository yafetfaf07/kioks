import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserLoginpage extends StatefulWidget {
  const UserLoginpage({super.key});

  @override
  State<UserLoginpage> createState() => _UserLoginpageState();
}

class _UserLoginpageState extends State<UserLoginpage> {
  final GlobalKey<FormState> _loginFormkey = GlobalKey<FormState>();
  final TextEditingController _phonenumbertext = TextEditingController();
  final TextEditingController _passwordtext = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: Column(
            children: [
              Text(
                'LogIn',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                ),
                textAlign: TextAlign.center,
              ),
              Form(
                key: _loginFormkey,
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Phone Number',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormField(
                        controller: _phonenumbertext,
                        validator: (value) {
                          return null;
                        },

                        decoration: InputDecoration(
                          hintText: ' Phone no',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Password',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _passwordtext,
                        validator: (value) {
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: ' Password',
                          border: InputBorder.none,
                        ),
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(height: 40),
                    FractionallySizedBox(
                      widthFactor: 0.8,

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
                          'Login',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
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
      ),
    );
  }
}
