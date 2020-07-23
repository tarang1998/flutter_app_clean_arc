
import 'package:brew_app_clean_arc/features/brew/domain/entities/brew.dart';
import 'package:brew_app_clean_arc/features/brew/domain/entities/userdata.dart';
import 'package:brew_app_clean_arc/features/brew/domain/repositories/brew_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BrewRepositoryImpl implements BrewRepository {

  final CollectionReference brewCollection = Firestore.instance.collection('brews');


  Future updateUserData(String uid,String sugars, String name , int strength) async{
    return await brewCollection.document(uid).setData({
      'sugars':sugars,
      'name':name,
      'strength':strength
    });
  }



  //brew list from snapshot
  List <Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((document) {
      return Brew(
        name:document.data['name']??'',
        strength: document.data['strength']??0,
        sugar: document.data['sugars']??'0',
      );
    }).toList();
  }



  //brew stream from the firestore
  //stream is received when we add a document to the collection,or modify remove it or the screen loads up
  //returns a snapshot of the collection
  Stream<List<Brew>> get brews{
    return brewCollection.snapshots()
        .map(_brewListFromSnapshot);
  }



  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid:snapshot.data['uid'],
        name: snapshot.data['name'],
        sugars: snapshot.data['sugars'],
        strength: snapshot.data['strength']
    );
  }



  // get user doc stream
  Stream<UserData> userData(String uid) {
    return brewCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);

  }

}