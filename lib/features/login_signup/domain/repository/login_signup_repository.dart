

import 'package:brew_app_clean_arc/features/login_signup/domain/entity/user.dart';

abstract class LoginSignUpRepository {


  Future<User>  signInWithGoogle();

  Future<void> signInWithCredentials(String email, String password) ;

  Future<void> signUp(String email, String password);

  Future<void> signOut();

  Future<bool> isSignedIn();

  Future<User> getUser();


  }