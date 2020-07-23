
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';



@immutable
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}



//an AppStarted event to notify the bloc that it needs to check if the user is currently authenticated or not.
//Called when the app starts
class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}




//a LoggedIn event to notify the bloc that the user has successfully logged in.
class LoggedIn extends AuthenticationEvent {
  @override
  String toString() => 'LoggedIn';
}





//a LoggedOut event to notify the bloc that the user has successfully logged out.
class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}


