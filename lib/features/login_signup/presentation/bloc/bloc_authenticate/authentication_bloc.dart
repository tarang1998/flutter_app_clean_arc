
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:brew_app_clean_arc/core/usecase/usecase.dart';
import 'package:brew_app_clean_arc/features/login_signup/domain/entity/user.dart';
import 'package:brew_app_clean_arc/features/login_signup/domain/usecases/check_signedin.dart';
import 'package:brew_app_clean_arc/features/login_signup/domain/usecases/getUser.dart';
import 'package:brew_app_clean_arc/features/login_signup/domain/usecases/sign_out.dart';
import 'package:brew_app_clean_arc/features/login_signup/presentation/bloc/bloc_authenticate/bloc.dart';
import 'package:meta/meta.dart';


class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  //final UserRepository _userRepository;

//  AuthenticationBloc({@required UserRepository userRepository})
//      : assert(userRepository != null),
//        _userRepository = userRepository;


  final IsSignedIn isSigned;
  final GetUser getUser;
  final SignOut signOut;

  AuthenticationBloc({
    @required IsSignedIn issignedin,
    @required GetUser getuser,
    @required SignOut signout

  })  : assert(issignedin != null),
        assert(getuser!=null),
        assert(signout!=null),
        this.isSigned=issignedin,
        this.getUser=getuser,
        this.signOut=signout;


  //initial-state
  //since the first thing our app will need to do is determine whether or not a user is logged in.
  @override
  AuthenticationState get initialState => Uninitialized();

  //Generator function does not get executed until someone tries to listen to the stream it returns.*** sync*, async*, yield and yield*
  //Yield* keyword is used for ‘returning’ recursive generator:
  // We are using yield* (yield-each) in mapEventToState to separate the event handlers into their own functions.
  // yield* inserts all the elements of the subsequence into the sequence currently being constructed,
  // as if we had an individual yield for each element.
  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event,) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }
    else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    }
    else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  //when the app starts app starts event is passed
  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await isSigned(NoParams());
      if (isSignedIn) {
        final User user = await getUser(NoParams());
        yield Authenticated(user.email,user.uid);
      }
      else {
        yield Unauthenticated();
      }
    }
    catch (_) {
      yield Unauthenticated();
    }
  }

  //async* Generator functions produce sequence of values(in contrast to regular functions that return single value).
  //Yield is a keyword that ‘returns’ single value to the sequence, but does not stop the generator function.
  Stream<AuthenticationState> _mapLoggedInToState() async* {
    User user=await getUser(NoParams());
    yield Authenticated(user.email,user.uid);
  }





  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    signOut(NoParams());
  }
}