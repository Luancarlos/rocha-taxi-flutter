import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxirocha/components/SideMenu.dart';

import '../../util.dart';
import 'address.dart';
import 'package:geolocator/geolocator.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: primaryColor,
      ),
      home: MapPage(),
    );
  }
}

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPage();
}

class _MapPage extends State<MapPage> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  BitmapDescriptor _markerIcon;
  GoogleMapController controller;
  Set<Marker> markers = <Marker>[].toSet();

  double rotate01 = 0;
  double rotate02 = 0;

  Position position;
  LatLng location = LatLng(-8.994199, -40.271823);
  CameraPosition cameraPosition =
      new CameraPosition(target: LatLng(-8.997233, -40.272655), zoom: 5);

  @override
  void initState() {
    getLocation().then((res) {
      configureMarkers();
    });

    super.initState();
  }

  configureMarkers() {
    var rd = Random();
    double lat = position.latitude;
    double lng = position.longitude;
    setState(() {});

    markers.add(
        Marker(
          markerId: MarkerId("marker_1"),
          position: LatLng(lat - (rd.nextInt(399) * 0.00001), lng +(rd.nextInt(399) * 0.00001)),
          icon: _markerIcon,
          rotation: rotate01),
    );
    markers.add(
      Marker(
          markerId: MarkerId("marker_2"),
          position: LatLng(lat + (rd.nextInt(399) * 0.00001), lng -(rd.nextInt(399) * 0.00001)),
          icon: _markerIcon,
          rotation: (rd.nextInt(380) * 1.0)),
    );

    markers.add(
      Marker(
          markerId: MarkerId("marker_3"),
          position: LatLng(lat + (rd.nextInt(399) * 0.00001), lng +(rd.nextInt(399) * 0.00001)),
          icon: _markerIcon,
          rotation: (rd.nextInt(380) * 1.0)),
    );

    markers.add(
      Marker(
          markerId: MarkerId("marker_4"),
          position: LatLng(lat - (rd.nextInt(399) * 0.00001), lng +(rd.nextInt(399) * 0.00001)),
          icon: _markerIcon,
          rotation: rotate02),
    );


    var future = new Future.delayed(const Duration(milliseconds: 3500), (){
//      int i = rd.nextInt(4);
      setState(() {
        print('rotacao');
        rotate01 = (rd.nextInt(380) * 1.0);
        rotate02 = (rd.nextInt(380) * 1.0);
      });
    });
//
//    var timer = Timer.periodic(new Duration(milliseconds: 200), (timer) {
//      if(lat < -8.997258999999975) {
//        timer.cancel();
//      }
//      setState((){
//        lng2 -= 0.00003;
//        lat = lat - 0.00002;
//        _localCar2  = new LatLng(lat2, lng2);
//        _localCar   = new LatLng(lat, lng);
//      });
//    });
  }

  Future<void> getLocation() async {
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 16.5)));
    print(position.latitude);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    _createMarkerImageFromAsset(context);

    return Scaffold(
        key: _globalKey,
        drawer: SideMenu(),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: cameraPosition,
              onMapCreated: _onMapCreated,
              markers: markers,
              mapToolbarEnabled: false,
              myLocationButtonEnabled: false,
              rotateGesturesEnabled: false,
              zoomGesturesEnabled: true,
            ),
            Positioned(
              left: 10,
              top: 40,
              child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: 30,
                  ),
                  onPressed: () {
                    _globalKey.currentState.openDrawer();
                  }),
            ),
            Positioned(
                top: height * 0.12,
                left: width * 0.1,
                child: ButtonTheme(
                  minWidth: width * 0.8,
                  height: 45,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: RaisedButton(
                      elevation: 20,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ClipOval(
                            child: Container(
                              color: primaryColor,
                              width: 10,
                              height: 10,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text('Para onde?'),
                          SizedBox(width: width * 0.5),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                transitionDuration:
                                    const Duration(milliseconds: 450),
                                pageBuilder: (context, _, __) =>
                                    AddressPage()));
                      }),
                ))
          ],
        ));
  }

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, 'assets/images/icon_car_top.png')
          .then(_updateBitmap);
    }
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
    });
  }
}
