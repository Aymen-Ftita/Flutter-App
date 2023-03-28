import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late Position cl;

  Future getPosition() async {
    return await Geolocator.getCurrentPosition().then((value) {
      setState(() {
        cl = value;
      });
      // ignore: avoid_print
      print('cl lat : ${cl.latitude}');
      // ignore: avoid_print
      print('cl long : ${cl.longitude}');
    });
  }

  Future geolocator() async {
    bool services = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    // ignore: avoid_print
    print(permission);

    if (services == false) {
      // ignore: use_build_context_synchronously
      AwesomeDialog(
        context: context,
        title: "services",
        body: const Text("services Not Enaled"),
        desc: "Pleaze Turn On The Location Services",
      ).show();
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    } else {
      getPosition();
    }
  }

  @override
  void initState() {
    geolocator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
              child: TextButton(
                  onPressed: getPosition, child: const Text('Show LatLong')))),
    );
  }
}
