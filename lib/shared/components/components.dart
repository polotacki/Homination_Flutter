import 'package:flutter/material.dart';


void pushTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void pushReplacement(context, widget) =>
    pushReplacement(context, MaterialPageRoute(builder: (context) => widget));
