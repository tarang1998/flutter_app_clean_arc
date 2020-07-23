
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:brew_app_clean_arc/features/brew/domain/entities/brew.dart';
import 'package:brew_app_clean_arc/features/brew/domain/entities/userdata.dart';
import 'package:brew_app_clean_arc/features/brew/domain/usecases/GetBrews.dart';
import 'package:brew_app_clean_arc/features/brew/domain/usecases/GetUserBrewData.dart';
import 'package:brew_app_clean_arc/features/brew/domain/usecases/UpdateUserdata.dart';
import 'package:brew_app_clean_arc/features/brew/presentation/bloc/bloc.dart';
import 'package:flutter/cupertino.dart';




class BrewBloc extends Bloc<BrewEvent, BrewState> {

  final UpdateUserData updateUserData;
  final GetUserBrewData getUserBrewData;
  final GetBrews getBrews;

  BrewBloc({
    @required UpdateUserData updateuserdata,
    @required GetUserBrewData getuserbrewdata,
    @required GetBrews getbrews

  })
      : assert(updateuserdata != null),
        assert(getuserbrewdata != null),
        assert(getbrews != null),
        this.updateUserData=updateuserdata,
        this.getUserBrewData=getuserbrewdata,
        this.getBrews=getbrews;

  @override
  BrewState get initialState => BrewLoading();




  @override
  Stream<BrewState> mapEventToState(BrewEvent event,) async* {
    if (event is LoadData) {
      //print('Loaddata called');
      yield* _mapLoadDataToState();
    }
    else if (event is SettingsClicked){
      yield* _mapSettingsClickedToState(event.uid);
    }
    else if(event is UpdateUserDataEvent){
      yield* _mapUpdateUserDataToState(event.userdata);
    }
  }





  Stream<BrewState> _mapLoadDataToState() async* {
     List<Brew> brew;
    StreamSubscription sb;
    sb =  getBrews().listen((event) {
      //print(event);
//      brew=event;
      if (event is List<Brew>) {
        brew = event;
        sb.cancel();
      }
    });

    //print(brew);
     while(brew==null) {
       await new Future.delayed(new Duration(milliseconds: 250));
     }
    //await Future.delayed(Duration(seconds: 1));
    yield BrewLoaded(brew);
  }



  Stream<BrewState> _mapSettingsClickedToState(String uid) async* {
    UserData userdata;
    StreamSubscription sb;
    sb =  getUserBrewData(uid).listen((event) {
      if (event is UserData) {
        userdata = event;
        sb.cancel();
      }
    });
    while(userdata==null) {
      await new Future.delayed(new Duration(milliseconds: 250));
    }
    yield UserDataLoaded(userdata);
    //this.dispatch(LoadData());
  }




  Stream<BrewState> _mapUpdateUserDataToState(userdata) async* {
    updateUserData(Params(uid:userdata.uid,name:userdata.name,sugars: userdata.sugars,strength: userdata.strength));
    this.dispatch(LoadData());
  }

}