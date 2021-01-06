import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uberClone/brand_colors.dart';
import 'package:uberClone/widgets/CustomDevider.dart';

class MainPage extends StatefulWidget {
  static const String id = 'mainPage';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  double mapBottomPadding = 0.0;

  void showSnakbar(String title) {
    final snackBar = SnackBar(
        content: Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 15),
    ));
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  // var geoLoacator = Geolocator();
  Position currentPostion;
  void setupPositionLocator() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );
    currentPostion = position;
    LatLng pos = LatLng(
      position.latitude,
      position.longitude,
    );
    CameraPosition cp = CameraPosition(target: pos, zoom: 14);
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(cp),
    );
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        key: scaffoldKey,

        //Left Side  Drawer Code Starts Here
        drawer: Container(
          color: Colors.white,
          width: size.width * 0.7,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.all(
                0.0,
              ),
              children: [
                Container(
                  height: size.height * 0.2,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'images/user_icon.png',
                          height: size.width * 0.2,
                          width: size.width * 0.2,
                        ),
                        SizedBox(
                          width: size.width * 0.035,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Zamir Haider",
                              style: TextStyle(
                                fontSize: size.width * 0.05,
                                fontFamily: 'Brand-Bold',
                              ),
                            ),
                            SizedBox(
                              height: size.width * 0.02,
                            ),
                            Text(
                              'View Profile',
                            ),
                            CustomDevider(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.width * 0.02,
                ),
                ListTile(
                  leading: Icon(
                    Icons.card_giftcard_outlined,
                  ),
                  title: Text(
                    "Free Rides",
                    style: TextStyle(fontSize: size.width * 0.042),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.credit_card_outlined,
                  ),
                  title: Text(
                    "Payments",
                    style: TextStyle(fontSize: size.width * 0.042),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.history_outlined,
                  ),
                  title: Text(
                    "History",
                    style: TextStyle(fontSize: size.width * 0.042),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.contact_support_outlined,
                  ),
                  title: Text(
                    "Support",
                    style: TextStyle(fontSize: size.width * 0.042),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.info_outline,
                  ),
                  title: Text(
                    "About",
                    style: TextStyle(fontSize: size.width * 0.042),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            GoogleMap(
              padding: EdgeInsets.only(
                bottom: mapBottomPadding,
                top: size.height * 0.03,
              ),
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              tiltGesturesEnabled: true,
              initialCameraPosition: _kGooglePlex,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                mapController = controller;
                setState(() {
                  mapBottomPadding = size.height * 0.32;
                });
                setupPositionLocator();
              },
            ),

            // FloatingActionButton(

            //   backgroundColor: Colors.white,
            //   onPressed: setupPositionLocator,
            //   child: Icon(
            //     Icons.my_location,
            //     color: Colors.black87,
            //   ),
            // ),

            // Menu Button
            Positioned(
              top: size.width * 0.1,
              left: size.width * 0.04,
              child: GestureDetector(
                onTap: () {
                  scaffoldKey.currentState.openDrawer();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      size.width * 0.08,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: size.width * 0.02,
                        spreadRadius: size.width * 0.001,
                        offset: Offset(
                          0.7,
                          0.7,
                        ),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: size.width * 0.055,
                    child: Icon(
                      Icons.menu,
                      size: size.width * 0.085,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
            //Search Sheet
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                height: size.height * 0.32,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        size.width * 0.05,
                      ),
                      topRight: Radius.circular(
                        size.width * 0.05,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: size.width * 0.015,
                        spreadRadius: size.width * 0.015,
                        offset: Offset(
                          0.7,
                          0.7,
                        ),
                      )
                    ]),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.08,
                    vertical: size.width * 0.025,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      Text(
                        "Nice to see you",
                        style: TextStyle(fontSize: size.width * 0.034),
                      ),
                      Text(
                        "Where are you going?",
                        style: TextStyle(
                            fontSize: size.width * 0.042,
                            fontFamily: 'Brand-Bold'),
                      ),
                      SizedBox(
                        height: size.width * 0.03,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              size.width * 0.015,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: size.width * 0.001,
                                blurRadius: size.width * 0.02,
                                offset: Offset(
                                  0.7,
                                  0.7,
                                ),
                              ),
                            ]),
                        child: Padding(
                          padding: EdgeInsets.all(size.width * 0.025),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.blueAccent,
                              ),
                              SizedBox(
                                width: size.width * 0.015,
                              ),
                              Text('Search Destination')
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.home_outlined,
                            color: BrandColors.colorDimText,
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add Home',
                                // style: TextStyle(
                                //   color: BrandColors.colorDimText,
                                //   fontSize: size.width * 0.03,
                                // ),
                              ),
                              SizedBox(
                                height: size.width * 0.01,
                              ),
                              Text(
                                'Your resedential address',
                                style: TextStyle(
                                  color: BrandColors.colorDimText,
                                  fontSize: size.width * 0.03,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.width * 0.02,
                      ),
                      CustomDevider(),
                      SizedBox(
                        height: size.width * 0.02,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.work_outline,
                            color: BrandColors.colorDimText,
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add Work',
                                // style: TextStyle(
                                //   color: BrandColors.colorDimText,
                                //   fontSize: size.width * 0.03,
                                // ),
                              ),
                              SizedBox(
                                height: size.width * 0.01,
                              ),
                              Text(
                                'Your office address',
                                style: TextStyle(
                                  color: BrandColors.colorDimText,
                                  fontSize: size.width * 0.03,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
