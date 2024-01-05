// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
//
// class LocationUpdateScreen extends StatefulWidget {
//   const LocationUpdateScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LocationUpdateScreen> createState() => _LocationUpdateScreenState();
// }
//
// class _LocationUpdateScreenState extends State<LocationUpdateScreen> {
//   late final Timer timer;
//   int markerIndex = 0;
//   late final MapController mapController;
//   @override
//   void initState(){
//     super.initState();
//     mapController=new MapController();
//     timer = Timer.periodic(const Duration(seconds: 2), (_) {
//       // print(marker.value?.point.latitude);
//       // print( marker.value?.point.longitude);
//       // marker.value = markers[markerIndex.value];
//       markerIndex++;
//      // if(mapController!=null)
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child:Text('index-${markerIndex}')
//     );
//   }
// }