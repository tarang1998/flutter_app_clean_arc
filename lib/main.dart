
import 'package:brew_app_clean_arc/features/login_signup/presentation/bloc/bloc_authenticate/bloc.dart';
import 'package:brew_app_clean_arc/features/login_signup/presentation/pages/home.dart';
import 'package:brew_app_clean_arc/features/login_signup/presentation/pages/login.dart';
import 'package:brew_app_clean_arc/features/login_signup/presentation/pages/splash.dart';
import 'file:///C:/Users/taran/App_dev/Projects/brew_app_clean_arc/lib/simple_bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'injection_container.dart' as di;


void main() async {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  await di.init();
  runApp(App());
}


class App extends StatefulWidget {
  State<App> createState() => _AppState();
}


class _AppState extends State<App> {
  //We create an instance of UserRepository in our _AppState class and then inject it into our AuthenticationBloc in initState
  //final UserRepository _userRepository = UserRepository();
  // Since we created the AuthenticationBloc in _AppState we need to clean up after ourselves and dispose of it in _AppState.
  AuthenticationBloc _authenticationBloc;


  @override
  void initState() {
    super.initState();
    //_authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc = di.sl<AuthenticationBloc>();
    _authenticationBloc.dispatch(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    //We are using BlocProvider in order to make our _authenticationBloc instance available to the entire Widget sub-tree.
    return BlocProvider(
      bloc: _authenticationBloc,
      child:MaterialApp(
        // We are also using BlocBuilder in order to render UI based on the _authenticationBloc state.
        home: BlocBuilder(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {

            if (state is Uninitialized) {
              print('Splash page loaded');
              return SplashPage();
            }
            if (state is Unauthenticated) {
              return LoginScreen();
            }
            if (state is Authenticated) {
              return HomeScreen(name: state.displayName, uid:state.uid);
            }
            return Container();
          },
        ),
      )
    );

  }





  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }
}
