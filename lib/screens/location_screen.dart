import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/screens/search.dart';
import 'package:weather_app/services/weather.dart';

import '../services/location.dart';
import '../utilities/constants.dart';
import 'loading_screen.dart';

class LocationScreen extends StatefulWidget {
  final WeatherModel weatherData;
  const LocationScreen({super.key, required this.weatherData});

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  late int temp;
  late String cityName;
  late String icon;
  late String description;
  bool isLoaded = false;
  final ImageProvider imageAsset =AssetImage('images/location_background.jpg') ;
  final ImageProvider imageNetwork = NetworkImage('https://source.unsplash.com/random/?nature,day') ;
//  bool isLoaded = false;



   void getImageProvider(){
     imageNetwork.resolve(ImageConfiguration()).addListener(ImageStreamListener((image, synchronousCall) {
       setState(() {
         isLoaded=true;
       });
     }));
   }
  @override
  void initState() {
    temp = widget.weatherData.temp.toInt();
    cityName = widget.weatherData.name;
    icon = widget.weatherData.getWeatherIcon();
    description = widget.weatherData.getMessage();
    super.initState();
    getImageProvider();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image : !isLoaded? imageAsset:imageNetwork,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.8), BlendMode.dstATop),
              ),
            ),
            constraints: const BoxConstraints.expand(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.white.withOpacity(0.0),
                    Colors.white.withOpacity(0.0)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  // color: Colors.white.withOpacity(0.0),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(                        //                        getWeatherDataSelected(data);
                      onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoadingScreen()));
                        },
                        child: const Icon(
                          Icons.near_me,
                          size: 50.0,
                          color: kSecondaryColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ListViewSearchExample()));
                        },
                        child: const Icon(
                          Icons.location_city,
                          size: 50.0,
                          color: kSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('$icon'),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '$temp',
                            style: kTempTextStyle,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.black, width: 10),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                height: 12,
                                width: 42,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10)
                                    // shape: BoxShape.circle,
                                    ),
                              ),
                              const Text(
                                'now',
                                style: TextStyle(
                                  fontSize: 45.0,
                                  fontFamily: 'Spartan MB',
                                  letterSpacing: 13,
                                ),
                              ),
                              SizedBox(height: 30,),
                              Container(
                                height: 200,
                                width: 250,
                                child: RichText(
                                  text:  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: cityName,
                                        style: const TextStyle(
                                          fontSize: 40,
                                          fontFamily: 'Spartan MB',
                                          letterSpacing: 8,
                                          color: Colors.black87
                                        ),
                                      ),
                                    ]

                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 24.0),
                  child: Text(
                    '$description',
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
                ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      padding: EdgeInsets.all(34),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                      ),
                      child: Text(''),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


