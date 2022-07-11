import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class SignatureViewPage extends StatefulWidget {
  final Uint8List? signature;

  const SignatureViewPage({Key? key, required this.signature})
      : super(key: key);

  @override
  State<SignatureViewPage> createState() => _SignatureViewPageState();
}

class _SignatureViewPageState extends State<SignatureViewPage> {

  Future storeSignature(BuildContext context) async {
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    final time = DateTime.now().toIso8601String().replaceAll('.', ':');
    final name = 'signature_$time.png';

    final result = await ImageGallerySaver.saveImage(
        widget.signature!, name: name);
    final isSuccess = result['isSuccess'];

    if (isSuccess) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Saved to signature"),),);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to save signature"),),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: const CloseButton(),
        title: const Text("Store Signature"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.done),
            onPressed: () => storeSignature(context),
          ),
        ],
      ),
      body: Center(
        child: Image.memory(widget.signature!, width: double.infinity,),
      ),
    );
  }
}
