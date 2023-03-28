import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fspotify/pages/map_screen.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  var getResult = 'QR Code Result';

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;

      setState(() {
        getResult = qrCode;
      });

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MapScreen()));
      // ignore: avoid_print
      print("QRCode_Result:--");
      // ignore: avoid_print
      print(qrCode);
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 46, 85, 139),
        title: const Text('QR Scanner'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: const ButtonStyle(),
            onPressed: () {
              scanQRCode();
            },
            child: const Text('Scan QR'),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(getResult),
        ],
      )),
    );
  }
}
