




import 'package:brew_app_clean_arc/features/login_signup/domain/entity/user.dart';
import 'package:brew_app_clean_arc/features/login_signup/domain/repository/login_signup_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginSignUpRepositoryImpl implements LoginSignUpRepository {

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  //for creating collection brews when the user first registers
  final CollectionReference brewCollection = Firestore.instance.collection('brews');


  //If FirebaseAuth and/or GoogleSignIn are not injected into the UserRepository, then we instantiate them internally
  LoginSignUpRepositoryImpl({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();


  //SignIn with google
  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    FirebaseUser user = await _firebaseAuth.currentUser();

    await updateUserData(user.uid,'0','new crew member',100);


    return _userfromFirebaseUser(user);

  }


  //Sign in with credentials
  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }



  //SignUp
  Future<void> signUp(String email, String password) async {
     await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

     FirebaseUser user = await _firebaseAuth.currentUser();

     await updateUserData(user.uid,'0','new crew member',100);

  }

  //SignOut
  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  //To Check if the user is logged in/out
  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  //getUser is only returning the current user's email address
  Future<User> getUser() async {
    FirebaseUser user=await _firebaseAuth.currentUser();
    return _userfromFirebaseUser(user);
  }



  //create user object based on firebase User
  User _userfromFirebaseUser(FirebaseUser user){
    return user!=null?User(uid:user.uid,email:user.email):null;

  }


  Future updateUserData(String uid,String sugars, String name , int strength) async{
    //creates a document with the uid if it doesnt exist already
    return await brewCollection.document(uid).setData({
      'sugars':sugars,
      'name':name,
      'strength':strength
    });
  }



}