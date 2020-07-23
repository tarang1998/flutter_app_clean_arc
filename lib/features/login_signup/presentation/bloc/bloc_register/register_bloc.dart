
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:brew_app_clean_arc/features/login_signup/domain/usecases/signup.dart';
import 'package:brew_app_clean_arc/features/login_signup/domain/usecases/validators.dart';
import 'package:brew_app_clean_arc/features/login_signup/presentation/bloc/bloc_register/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
//  final UserRepository _userRepository;
//
//  RegisterBloc({@required UserRepository userRepository})
//      : assert(userRepository != null),
//        _userRepository = userRepository;



  final SignUp signUp;

  RegisterBloc({
    @required SignUp signup,

  })  : assert(signup != null),
        this.signUp=signup;



  @override
  RegisterState get initialState => RegisterState.empty();



  @override
  Stream<RegisterState> transform(
      Stream<RegisterEvent> events,
      Stream<RegisterState> Function(RegisterEvent event) next,
      ) {
    final observableStream = events as Observable<RegisterEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is EmailChanged || event is PasswordChanged);
    }).debounce(Duration(milliseconds: 300));
    return super.transform(nonDebounceStream.mergeWith([debounceStream]), next);
  }



  @override
  Stream<RegisterState> mapEventToState(
      RegisterEvent event,
      ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.email, event.password);
    }
  }



  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield currentState.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  


  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield currentState.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }





  Stream<RegisterState> _mapFormSubmittedToState(
      String email,
      String password,
      ) async* {
    yield RegisterState.loading();
    try {
//      await _userRepository.signUp(
//        email: email,
//        password: password,
//      );

        await signUp(Params(email:email,password: password));
        yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}
