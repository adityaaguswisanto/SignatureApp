import 'package:flutter/material.dart';
import 'package:flutter_signature/ui/signature_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Signature Save Image",
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: const SignaturePage(),
    );
  }
}
