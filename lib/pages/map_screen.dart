//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late Position? cl;

  late double? lat = 36.8064933;

  late double? long = 10.18153;

  Future getPosition() async {
    return await Geolocator.getCurrentPosition().then((value) {
      setState(() {
        cl = value;
        lat = value.latitude;
        long = value.longitude;
      });
      print('cl lat : ${cl!.latitude}');
      // ignore: avoid_print
      print('cl long : ${cl!.longitude}');
    });
  }

  Future geolocator() async {
    bool services = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    // ignore: avoid_print
    print(permission);

    /*if(services==false){
      // ignore: use_build_context_synchronously
      AwesomeDialog(
        context: context,
        title: "services",
        body:const Text("services Not Enaled"),
        desc:"Pleaze Turn On The Location Services" , ).show();
    }else if(permission==LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }else{
      getPosition();
    }*/

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (services == false) {
        // ignore: use_build_context_synchronously
        AwesomeDialog(
          context: context,
          title: "services",
          body: const Text("services Not Enaled"),
          desc: "Pleaze Turn On The Location Services",
        ).show();
      }
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
    // ignore: prefer_const_constructors
    return Scaffold(

        // ignore: unrelated_type_equality_checks, unnecessary_null_comparison
        body: OpenStreetMapSearchAndPick(
            center: LatLong(lat!, long!),
            buttonColor: const Color.fromARGB(255, 46, 85, 139),
            buttonText: 'Set Current Location',
            onPicked: (pickedData) {
              print(cl?.latitude);
              print(
                  '================================================================');
              print(cl?.longitude);

              /*// ignore: avoid_print
          print(pickedData.latLong.latitude);
          // ignore: avoid_print
          print(pickedData.latLong.longitude);
          // ignore: avoid_print
          print(pickedData.address);*/
            }));
  }
}
