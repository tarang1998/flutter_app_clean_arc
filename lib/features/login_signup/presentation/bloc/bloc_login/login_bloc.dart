
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:brew_app_clean_arc/core/usecase/usecase.dart';
import 'package:brew_app_clean_arc/features/login_signup/domain/usecases/signin_credentials.dart';
import 'package:brew_app_clean_arc/features/login_signup/domain/usecases/signin_google.dart';
import 'package:brew_app_clean_arc/features/login_signup/domain/usecases/validators.dart';
import 'package:brew_app_clean_arc/features/login_signup/presentation/bloc/bloc_login/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';





class LoginBloc extends Bloc<LoginEvent, LoginState> {
  //UserRepository _userRepository;

//  LoginBloc({
//    @required UserRepository userRepository,
//  })  : assert(userRepository != null),
//        _userRepository = userRepository;

  final SignInWithGoogle signInGoogle;
  final SignInWithCredentials signInCredentials;

  LoginBloc({
    @required SignInWithGoogle signingoogle,
    @required SignInWithCredentials signincredentials,

  })  : assert(signingoogle != null),
        assert(signincredentials!=null),
        this.signInGoogle=signingoogle,
        this.signInCredentials=signincredentials;

  @override
  LoginState get initialState => LoginState.empty();


  //We’re overriding transform in order to debounce the EmailChanged and PasswordChanged
  // events so that we give the user some time to stop typing before validating the input.
  @override
  Stream<LoginState> transform(
      Stream<LoginEvent> events,
      Stream<LoginState> Function(LoginEvent event) next,
      ) {
    final observableStream = events as Observable<LoginEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    ////
    final debounceStream = observableStream.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounce(Duration(milliseconds: 300));
    return super.transform(nonDebounceStream.mergeWith([debounceStream]), next);
  }



  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    }
    else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    }
    else if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
    else if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }



  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield currentState.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }





  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield currentState.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }





  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      //await _userRepository.signInWithGoogle();
      await signInGoogle(NoParams());
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }





  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginState.loading();
    try {
      await signInCredentials(Params(email:email, password: password));
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}