


import 'package:brew_app_clean_arc/features/brew/data/repositories/Brew_repository_impl.dart';
import 'package:brew_app_clean_arc/features/brew/domain/repositories/brew_repository.dart';
import 'package:brew_app_clean_arc/features/brew/domain/usecases/GetBrews.dart';
import 'package:brew_app_clean_arc/features/brew/domain/usecases/GetUserBrewData.dart';
import 'package:brew_app_clean_arc/features/brew/domain/usecases/UpdateUserdata.dart';
import 'package:brew_app_clean_arc/features/brew/presentation/bloc/bloc.dart';
import 'package:brew_app_clean_arc/features/login_signup/data/repositories/Login_signup_repository_impl.dart';
import 'package:brew_app_clean_arc/features/login_signup/domain/repository/login_signup_repository.dart';
import 'package:brew_app_clean_arc/features/login_signup/domain/usecases/check_signedin.dart';
import 'package:brew_app_clean_arc/features/login_signup/domain/usecases/getUser.dart';
import 'package:brew_app_clean_arc/features/login_signup/domain/usecases/sign_out.dart';
import 'package:brew_app_clean_arc/features/login_signup/domain/usecases/signin_credentials.dart';
import 'package:brew_app_clean_arc/features/login_signup/domain/usecases/signin_google.dart';
import 'package:brew_app_clean_arc/features/login_signup/domain/usecases/signup.dart';
import 'package:brew_app_clean_arc/features/login_signup/presentation/bloc/bloc_authenticate/bloc.dart';
import 'package:brew_app_clean_arc/features/login_signup/presentation/bloc/bloc_login/bloc.dart';
import 'package:brew_app_clean_arc/features/login_signup/presentation/bloc/bloc_register/bloc.dart';
import 'package:get_it/get_it.dart';

final sl=GetIt.instance;

Future<void> init() async{

  //Blocs
  //login-register-auth
  sl.registerFactory(() => RegisterBloc(
    signup: sl(),
  ));

  sl.registerFactory(() => LoginBloc(
    signincredentials:sl(),
    signingoogle: sl(),
  ));

  sl.registerFactory(() => AuthenticationBloc(
    issignedin: sl(),
    getuser: sl(),
    signout: sl(),
  ));


  sl.registerFactory(() => BrewBloc(
    updateuserdata: sl(),
    getuserbrewdata: sl(),
    getbrews: sl(),
  ));






  //Usecases
  //login-register
  sl.registerLazySingleton(() => SignUp(sl()));
  sl.registerLazySingleton(() => SignInWithGoogle(sl()));
  sl.registerLazySingleton(() => SignInWithCredentials(sl()));
  sl.registerLazySingleton(() => IsSignedIn(sl()));
  sl.registerLazySingleton(() => GetUser(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));

  //brew
  sl.registerLazySingleton(() => UpdateUserData(sl()));
  sl.registerLazySingleton(() => GetUserBrewData(sl()));
  sl.registerLazySingleton(() => GetBrews(sl()));





  //repo
  //login-register
  sl.registerLazySingleton<LoginSignUpRepository>(() => LoginSignUpRepositoryImpl(),);

  //brew
  sl.registerLazySingleton<BrewRepository>(() => BrewRepositoryImpl());







}