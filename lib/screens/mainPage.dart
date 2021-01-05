import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uberClone/brand_colors.dart';
import 'package:uberClone/widgets/CustomDevider.dart';

class MainPage extends StatefulWidget {
  static const String id = 'mainPage';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  double mapBottomPadding = 0.0;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        drawer: Container(
          color: Colors.white,
          width: size.width * 0.4,
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
                          height: size.width * 0.25,
                          width: size.width * 0.25,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            GoogleMap(
              padding: EdgeInsets.only(bottom: mapBottomPadding),
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                mapController = controller;
                setState(() {
                  mapBottomPadding = size.height * 0.35;
                });
              },
            ),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                height: size.height * 0.35,
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
