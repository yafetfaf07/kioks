import 'package:flutter/material.dart';

class KioksPage extends StatefulWidget {
  const KioksPage({super.key});

  @override
  State<KioksPage> createState() => _KioksPageState();
}

class _KioksPageState extends State<KioksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('data'),
      ),
    );
  }
}