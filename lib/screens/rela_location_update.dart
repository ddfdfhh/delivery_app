import 'dart:async';
import 'dart:convert';

import 'package:delivery/constants.dart';
import 'package:delivery/controllers/order_controller.dart';
import 'package:delivery/theme.dart';
import 'package:delivery/widgets/expansion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class Loc extends StatefulWidget {
  Map<String, dynamic> user;

  Loc({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<Loc> createState() => _LocState();
}

class _LocState extends State<Loc> with TickerProviderStateMixin {
  Timer? timer;
  int markerIndex = 0;
  List<dynamic> points = [];
  double distance = 0;
  double speed = 0;
  List<LatLng> points1 = <LatLng>[];
  StreamSubscription<Position>? positionStream;
  // List<Marker> markers = [
  //   Marker(
  //     width: 20,
  //     height: 20,
  //     point: LatLng(26.93506797875862, 80.98021812428027),
  //     child: FlutterLogo(size: 2),
  //   ),
  //   Marker(
  //     width: 20,
  //     height: 20,
  //     point: LatLng(26.941043586049698, 80.98239156347752),
  //     child: FlutterLogo(size: 2),
  //   ),
  //   Marker(
  //     width: 20,
  //     height: 20,
  //     point: LatLng(26.947776771666035, 80.98728391267403),
  //     child: FlutterLogo(size: 2),
  //   ),
  //   Marker(
  //     width: 20,
  //     height: 20,
  //     point: LatLng(26.952290841364444, 80.99333497616324),
  //     child: FlutterLogo(size: 2),
  //   ),
  //   Marker(
  //     width: 20,
  //     height: 20,
  //     point: LatLng(26.959023355064154, 80.99899980157296),
  //     child: FlutterLogo(size: 2),
  //   ),
  // ];
  Marker? driverMarker;
  late Marker destinationMarker;
  Position? currentPosition = null as Position?;
  Position? lastPosition = null as Position?;
  double? start_latitude;
  double? start_longitude;
  double? end_latitude;
  double? end_longitude;
  late final destination_latitude;
  late final destination_longitude;

  late final AnimatedMapController animatedMapmapController;
  @override
  void initState() {
    super.initState();
    print('called');

    destination_latitude = widget.user['lat'] != null
        ? double.parse(widget.user['lat'])
        : 26.8730007;
    destination_longitude = widget.user['lang'] != null
        ? double.parse(widget.user['lang'])
        : 81.0329953;
    animatedMapmapController = AnimatedMapController(
        vsync: this,
        duration: const Duration(milliseconds: 2000),
        curve: Curves.easeInOut);

    getCurrentPosition();
  }


  getCurrentPosition() async {
    print('goooot');
    print(destination_latitude);
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "Location permissions are denied.Please enable location permission from the app settings",
        backgroundColor: Colors.redAccent,
        titleStyle: TextStyle(color: Colors.white),
        middleTextStyle: TextStyle(color: Colors.white),
      );
      return;
    } else {
      currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      await listRoutePoints();
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    bool requestPermission = false;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print('is service enable');
    print(serviceEnabled);
    if (!serviceEnabled) {
      requestPermission = true;
    } else {
      permission = await Geolocator.checkPermission();
      print('delhoj');
      print(permission);
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        requestPermission = true;
      }
    }
    if (requestPermission) {
      print('dddff check');
      permission = await Geolocator.checkPermission();
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          "Error",
          "Location permissions are denied.Please enable location to proceed",
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.add_alert),
        );

        return false;
      } else if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          "Error",
          "Location permissions are permanently denied,Please enable location to proceed.",
          colorText: Colors.white,
          backgroundColor: Colors.redAccent,
          icon: const Icon(Icons.add_alert),
        );

        return false;
      } else
        return true;
    } else
      return true;
  }

  @override
  void dispose() {
    if (timer != null) timer!.cancel();
    if (positionStream != null) positionStream!.cancel();
    super.dispose();
  }

  listRoutePoints() async {
    setState(() {
      start_longitude = currentPosition?.longitude != null
          ? currentPosition!.longitude
          : 80.9921546;
      start_latitude = currentPosition?.latitude != null
          ? currentPosition!.latitude
          : 26.884403;
      end_latitude = destination_latitude;
      end_longitude = destination_longitude;

      driverMarker =
          driverMapMarker(context, LatLng(start_latitude!, start_longitude!));
    });

    var response = await http.get(Uri.parse(
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf62483a792f92515c4b85aea75695b02645e7&start=${start_longitude},${start_latitude}&end=${end_longitude},${end_latitude}'));
    //http: //router.project-osrm.org/route/v1/driving/26.884403,80.9921546;13.397634,81.0329953;13.428555,52.523219?overview=false

    if (response.statusCode == 200) {

      var data = jsonDecode(response.body);

      List lp = data['features'][0]['geometry']['coordinates'];

      points = lp.map((e) => e.toList()).toList();

      if (points.isNotEmpty) {
        points1.clear();
        setState(() {
          points1 = points.map((el) {
            return LatLng(el[1], el[0]);
          }).toList();
        });
      }
    } else {
      setState(() {
        points1.add(LatLng(start_latitude!, start_longitude!));
        points1.add(LatLng(end_latitude!, end_longitude!));
      });
    }
    double dis = Geolocator.distanceBetween(
        start_latitude!, start_longitude!, end_latitude!, end_longitude!);

    setState(() {
      distance = dis;
    });
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.medium,
      distanceFilter: 10,
    );

    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((position) {
      LatLng g = LatLng(position.latitude, position.longitude);

      setState(() {
        speed = position.speed * 3.6;
        driverMarker = driverMapMarker(context, g);
        animatedMapmapController.animateTo(
            dest: g, zoom: 14, curve: Curves.ease);
      });
    });
  }

  OrderController oc = Get.find();
  @override
  Widget build(BuildContext context) {
    destinationMarker = customerMapMarker(
        context, LatLng(destination_latitude, destination_longitude));

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
                height: MediaQuery.of(context).size.height * .70,
                width: 500,
                child: start_latitude != null &&
                        points1.length >= 2 &&
                        driverMarker != null
                    ? FlutterMap(
                        mapController: animatedMapmapController.mapController,
                        options: MapOptions(
                          initialCenter:
                              LatLng(start_latitude!, start_longitude!),
                          initialZoom: 14,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.delivery.store',
                            tileProvider: CancellableNetworkTileProvider(),
                            // Use the recommended flutter_map_cancellable_tile_provider package to
                            // support the cancellation of loading tiles.
                          ),
                          MarkerLayer(
                              markers: [driverMarker!, destinationMarker!]),
                          PolylineLayer(
                            polylines: [
                              Polyline(
                                strokeWidth: 4,
                                points: points1,
                                color: Colors.red,
                              ),
                            ],
                          ),
                          // RichAttributionWidget(
                          //   popupInitialDisplayDuration: const Duration(seconds: 5),
                          //   animationConfig: const ScaleRAWA(),
                          //   showFlutterMapAttribution: false,
                          //   attributions: [
                          //     TextSourceAttribution(
                          //       'OpenStreetMap contributors',
                          //       onTap: () {},
                          //     ),
                          //     const TextSourceAttribution(
                          //       'This attribution is the same throughout this app, except '
                          //       'where otherwise specified',
                          //       prependCopyright: false,
                          //     ),
                          //   ],
                          // ),
                        ],
                      )
                    : Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator()))),
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
                color: Colors.blueGrey.shade50,
              ),
              height: 150,
              child: Card(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Delivery Address: ',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,color:AppTheme(context: context).colors['primary']
                                  )),

                        ],
                      ),
                      SizedBox(height: 5),
                      Center(
                        child: Text(
                            maxLines: 3,
                            '${widget.user['address']}}'),
                      ),
                      SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text('Distance(Km.)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17)),
                                SizedBox(height: 10),
                                Text('${(distance / 1000).toStringAsFixed(2)}',
                                    style: TextStyle(color: Colors.green))
                              ],
                            ),
                            Column(
                              children: [
                                Text('Speed(Km/s)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17)),
                                SizedBox(height: 10),
                                Text('${speed.toStringAsFixed(2)}',
                                    style: TextStyle(color: Colors.green))
                              ],
                            ),
                          ]),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Marker driverMapMarker(BuildContext context, LatLng g) {
    return Marker(
      width: 30,
      height: 30,
      point: g,
      child: Image.asset('${assetUrl(context)}/driver.jpg'),
    );
  }

  Marker customerMapMarker(BuildContext context, LatLng point) {
    return Marker(
      width: 30,
      height: 30,
      point: point,
      child: Image.asset('${assetUrl(context)}/customer.jpg'),
    );
  }
}
