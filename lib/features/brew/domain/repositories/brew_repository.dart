
import 'package:brew_app_clean_arc/features/brew/domain/entities/brew.dart';
import 'package:brew_app_clean_arc/features/brew/domain/entities/userdata.dart';

abstract class BrewRepository {


  Future updateUserData(String uid,String sugars, String name , int strength);


  Stream<List<Brew>> get brews;


  Stream<UserData> userData(String uid);



  }