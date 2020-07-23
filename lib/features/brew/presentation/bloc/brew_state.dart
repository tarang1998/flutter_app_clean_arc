

import 'package:brew_app_clean_arc/features/brew/domain/entities/brew.dart';
import 'package:brew_app_clean_arc/features/brew/domain/entities/userdata.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class BrewState extends Equatable {
  BrewState([List props = const []]) : super(props);
}



class BrewLoading extends BrewState {

  @override
  String toString() => 'BrewLoading';
}




class BrewLoaded extends BrewState {

  final List<Brew> brew;
  BrewLoaded(this.brew):super([brew]);

  @override
  String toString() => 'BrewLoaded';
}



class UserDataLoaded extends BrewState{
  final UserData userdata;
  UserDataLoaded(this.userdata):super([userdata]);

  @override
  String toString() => 'UserDataLoaded';

}