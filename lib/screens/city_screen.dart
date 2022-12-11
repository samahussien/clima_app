import 'package:flutter/material.dart';

import '../constants.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String? city;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon:   Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },

                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(

                  style: TextStyle(color: Colors.black),
                  decoration:kTextFieldDecoration,
                  onChanged: (value){
                    city=value;
                  },
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(primary: Colors.white),
                onPressed: () {
Navigator.pop(context,city);
                },
                child: Text(
                  'Get Weather',

                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}