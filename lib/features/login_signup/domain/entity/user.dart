import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';



class User extends Equatable{

  final String uid;
  final String email;

  User({@required this.uid,@required this.email}):super([uid,email]);

}
