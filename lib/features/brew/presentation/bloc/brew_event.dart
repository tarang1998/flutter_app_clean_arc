


import 'package:brew_app_clean_arc/features/brew/domain/entities/userdata.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class BrewEvent extends Equatable {
  BrewEvent([List props = const []]) : super(props);
}



class LoadData extends BrewEvent {
  @override
  String toString() => 'Loading Data';
}






class SettingsClicked extends BrewEvent{

  final String uid;

  SettingsClicked({@required this.uid})
      : super([uid]);

  @override
  String toString() => 'Settings clicked';
}





class UpdateUserDataEvent extends BrewEvent{

  final UserData userdata;

  UpdateUserDataEvent({@required this.userdata})
      : super([userdata]);

  @override
  String toString() => 'Settings clicked';
}



