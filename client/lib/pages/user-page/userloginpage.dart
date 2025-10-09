
import 'package:flutter/material.dart';
import 'package:flutter_project/pages/deliver-personnel-page/deliveryPage.dart';
import 'package:flutter_project/pages/merchant-page/MerchantDashboard.dart';
import 'package:flutter_project/pages/user-page/userhomepage.dart';
import 'package:flutter_project/services/auth.dart';
import 'package:google_fonts/google_fonts.dart';


class UserLoginpage extends StatefulWidget {
  const UserLoginpage({super.key});

  @override
  State<UserLoginpage> createState() => _UserLoginpageState();
}

class _UserLoginpageState extends State<UserLoginpage> {

  bool isUser = true;
  bool isMerchant = false;
  bool isDeliver = false;

  final GlobalKey<FormState> _loginFormkey = GlobalKey<FormState>();
  final TextEditingController _phonenumbertext = TextEditingController();
  final TextEditingController _passwordtext = TextEditingController();
  final AuthService _authService = AuthService(); 
    void _selectAccountType(String type) {
    setState(() {
      isUser = type == 'user';
      isMerchant = type == 'merchant';
      isDeliver = type == 'deliver';
    });
  }
Future<void> loginUser (String phoneNo, String password) async {

try {
   
  dynamic response= await _authService.login(phoneNo, password);
// print("Something $response");

if(response!=null) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(backgroundColor: Colors.green,content: Text('Login Successful')));
    if(isUser) {
      print("User Id: ,${response['data']['_id']}");
  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UserHomepage(id: response['data']['_id'])));
    }
    else if(isDeliver) {
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Deliverypage(id: response['_id'])));

    }
    else if(isMerchant) {
      print(response['_id']);
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => MerchantDashboard(id: response['_id'])));

    }
}
else {
  ScaffoldMessenger.of(context).showSnackBar( SnackBar(backgroundColor: Colors.red,content: Text(response['error'])));
}
}
catch(error) {
print("Error: $error");
}

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),
                Text(
                  'Log In',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 26,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
              Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.grey.shade200),
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
                            color: isDeliver ? Colors.white : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "Deliver Personnel",
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
                            color: isMerchant ? Colors.white : Colors.grey.shade200,
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
                Form(
                  key: _loginFormkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
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
                        controller: _phonenumbertext,
                        validator: (value) {
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 15,
                          ),
                          hintText: 'Enter your phone number',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white, width: 1),
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
                        controller: _passwordtext,
                        validator: (value) {
                          return null;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 15,
                          ),
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white, width: 1),
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
                      const SizedBox(height: 40),
                      FractionallySizedBox(
                        widthFactor: 0.99,
            
                        child: ElevatedButton(
                          onPressed: () {
                            loginUser(_phonenumbertext.text, _passwordtext.text);
                          },
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
                            'Log In',
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
                    Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.fromLTRB(2, 2, 3, 4)
                      ),
                      child: Text(
                        'Sign Up',
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
