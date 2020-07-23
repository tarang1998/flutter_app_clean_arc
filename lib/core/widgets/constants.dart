
import 'package:flutter/material.dart';

const TextInputDecoration=InputDecoration(

  //hintText: 'Email*',
    fillColor: Colors.white,
    filled:true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color:Colors.black,
            width:1
        )
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color:Colors.red,
            width:1
        )
    )
);