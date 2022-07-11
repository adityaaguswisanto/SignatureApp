import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_signature/ui/signature_view_page.dart';
import 'package:signature/signature.dart';

class SignaturePage extends StatefulWidget {
  const SignaturePage({Key? key}) : super(key: key);

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  var controller = SignatureController();

  Future<Uint8List?> exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 2,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
      points: controller.points,
    );

    final signature = await exportController.toPngBytes();
    exportController.dispose();

    return signature;
  }

  @override
  void initState() {
    super.initState();
    controller = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.black87,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Signature(
              controller: controller,
              backgroundColor: Colors.white,
            ),
          ),
          Container(
            color: Colors.black,
            child: Row(
              children: [
                Expanded(
                  child: IconButton(
                    onPressed: () async {
                      if (controller.isNotEmpty) {
                        final signature = await exportSignature();

                        await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              SignatureViewPage(signature: signature),
                        ));

                        controller.clear();
                      }
                    },
                    icon: const Icon(Icons.check),
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      controller.clear();
                    },
                    icon: const Icon(Icons.clear),
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
