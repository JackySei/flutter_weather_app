import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 100.0,
);

const kMessageTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 30.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  color: Colors.white,
);

const kConditionTextStyle = TextStyle(
  fontSize: 30.0,
  color: Colors.white,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ), //Icon
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ), //TextStyle
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);
