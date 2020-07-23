


import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class UserData extends Equatable{

  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData({
    @required this.uid,
    @required this.sugars,
    @required this.strength,
    @required this.name }):super([uid,name,sugars,strength]);
}

  String get uid{
    return uid;
  }

  String get name{
    return name;
  }

String get sugars{
  return sugars;
}

String get strength{
  return strength;
}