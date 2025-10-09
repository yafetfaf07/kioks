// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:geolocator/geolocator.dart';
// import 'dart:io';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
//       ),
//       home: const UserProfilePage(),
//     );
//   }
// }

// class UserProfilePage extends StatefulWidget {
//   const UserProfilePage({super.key});

//   @override
//   State<UserProfilePage> createState() => _UserProfilePageState();
// }

// class _UserProfilePageState extends State<UserProfilePage> {
//   File? _profileImage; // Store the selected image file
//   final ImagePicker _picker = ImagePicker(); 
//   String _location = 'Fetching location...'; // Store user location


//   Future<void> _pickImage() async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(
//         source: ImageSource.gallery,
//       );
//       if (pickedFile != null) {
//         setState(() {
//           _profileImage = File(pickedFile.path);
//         });
//       } else {
//         print('No image selected');
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(const SnackBar(content: Text('No image selected')));
//       }
//     } catch (e) {
//       print('Error picking image: $e');
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
//     }
//   }

  
//   Future<void> _getUserLocation() async {
//     try {
      
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         setState(() {
//           _location = 'Location services are disabled';
//         });
//         return;
//       }

//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           setState(() {
//             _location = 'Location permission denied';
//           });
//           return;
//         }
//       }

//       if (permission == LocationPermission.deniedForever) {
//         setState(() {
//           _location = 'Location permission permanently denied';
//         });
//         return;
//       }

//       // Get current position
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       setState(() {
//         _location = 'Lat: ${position.latitude}, Lon: ${position.longitude}';
//       });
//     } catch (e) {
//       print('Error getting location: $e');
//       setState(() {
//         _location = 'Error getting location: $e';
//       });
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text('Error getting location: $e')));
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _getUserLocation(); // Fetch location when page loads
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(

       
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           elevation: 0,
//           title: Text(
//             'Profile',
//             style: GoogleFonts.poppins(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
//           child: Column(
//             children: [
//               GestureDetector(
//                 onTap: _pickImage,
//                 child: CircleAvatar(
//                   radius: 60,
//                   backgroundColor: Colors.grey,
//                   child: CircleAvatar(
//                     radius: 55,
//                     backgroundImage:
//                         _profileImage != null
//                             ? FileImage(_profileImage!)
//                             : const NetworkImage(
//                               'https://via.placeholder.com/150',
//                             ),
//                     child:
//                         _profileImage == null
//                             ? const Icon(
//                               Icons.person,
//                               size: 60,
//                               color: Colors.white70,
//                             )
//                             : null,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 'abebe@gmail.com',
//                 style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
//               ),
//               const SizedBox(height: 30),
//               // Touchable List Items
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 8.0,
//                       horizontal: 16.0,
//                     ),
//                     child: Text(
//                       'Your Name: ',
//                       style: GoogleFonts.poppins(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.person,
//                       color: Color.fromARGB(255, 68, 167, 73),
//                     ),
//                     title: Text(
//                       'abebe',
//                       style: GoogleFonts.poppins(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black,
//                       ),
//                     ),
//                     trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                     onTap: () {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Tapped User Info')),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//               const Divider(height: 1, color: Colors.grey),
//               ListTile(
//                 leading: null, 
//                 title: Padding(
//                   padding: const EdgeInsets.only(
//                     left: 40.0,
//                   ), 
//                   child: Text('mola', style: GoogleFonts.poppins(fontSize: 16)),
//                 ),
//                 trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                 onTap: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Tapped User Info')),
//                   );
//                 },
//               ),
//               const Divider(height: 1, color: Colors.grey),
//               ListTile(
//                 leading: const Icon(
//                   Icons.my_location,
//                   color: Color.fromARGB(255, 68, 167, 73),
//                 ),
//                 title: Text(
//                   'Location',
//                   style: GoogleFonts.poppins(fontSize: 16),
//                 ),
//                 subtitle: Text(
//                   _location,
//                   style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
//                 ),
//                 trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                 onTap: _getUserLocation,
//               ),
//               const Divider(height: 1, color: Colors.grey),
//               ListTile(
//                 leading: const Icon(
//                   Icons.lock,
//                   color: Color.fromARGB(255, 68, 167, 73),
//                 ),
//                 title: Text(
//                   'Change Password',
//                   style: GoogleFonts.poppins(fontSize: 16),
//                 ),
//                 trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                 onTap: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Tapped Change Password')),
//                   );
//                 },
//               ),
//               const Divider(height: 1, color: Colors.grey),
//             ],
//           ),
//         ),

//         backgroundColor: Colors.white,
    

//       ),
//     );
//   }
// }
