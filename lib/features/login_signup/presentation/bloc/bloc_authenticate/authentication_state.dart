import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


//The equatable package is used in order to be able to compare two instances of AuthenticationState.
// Using Equatable == returns true only if the two objects are the same instance.
//An immutable class is simply a class whose instances cannot be modified.
@immutable
abstract class AuthenticationState extends Equatable {
  AuthenticationState([List props = const []]) : super(props);
}




//waiting to see if the user is authenticated or not on app start.
//the user might be seeing a splash screen
class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';
}



//successfully authenticated
//the user might see a home screen.
class Authenticated extends AuthenticationState {
  final String displayName;
  final String uid;

  Authenticated(this.displayName,this.uid) : super([displayName,uid]);

  //toString is overridden to make it easier to read an AuthenticationState when printing it to the console or in Transitions.
  @override
  String toString() => 'Authenticated { displayName: $displayName }';

}




//not authenticated
//the user might see a login form.
class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';
}