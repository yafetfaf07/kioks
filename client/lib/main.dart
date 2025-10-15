import 'package:flutter/material.dart';
import 'package:flutter_project/pages/user-page/usersignuppage.dart';
import 'package:flutter_project/pages/user-page/userhomepage.dart'; // Import UserHomePage
import 'package:flutter_project/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> _getInitialPage() async {
    const storage = FlutterSecureStorage();
    final String? accessToken = await storage.read(key: 'accessToken');

    if (accessToken != null && !JwtDecoder.isExpired(accessToken)) {
      // Token exists and is not expired
      return UserHomepage(id: JwtDecoder.decode(accessToken)['id']);
    } else {
      // Token is missing or expired
      return const UserSignUppage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(textTheme: GoogleFonts.geologicaTextTheme()),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<Widget>(
        future: _getInitialPage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while checking token
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasError) {
            // Handle errors (e.g., storage read issues)
            return const Scaffold(
              body: Center(child: Text('Error checking authentication')),
            );
          }
          // Return the resolved page (UserHomePage or UserSignUppage)
          return snapshot.data ?? const UserSignUppage();
        },
      ),
    );
  }
}
