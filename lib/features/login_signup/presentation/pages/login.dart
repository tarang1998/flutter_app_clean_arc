
import 'package:brew_app_clean_arc/features/login_signup/presentation/bloc/bloc_login/bloc.dart';
import 'package:brew_app_clean_arc/injection_container.dart';
import 'file:///C:/Users/taran/App_dev/Projects/brew_app_clean_arc/lib/features/login_signup/presentation/widgets/login_widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  //final UserRepository _userRepository;

//  LoginScreen({Key key, @required UserRepository userRepository})
//      : assert(userRepository != null),
//        _userRepository = userRepository,
//        super(key: key);

  LoginScreen({Key key});

  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;

  //UserRepository get _userRepository => widget._userRepository;

  @override
  //called before the built only once
  void initState() {
    super.initState();
    _loginBloc = sl<LoginBloc>();
//        LoginBloc(
//      userRepository: _userRepository,
//    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey[100],
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.grey[900],

      ),
      //Provider used to provide login bloc to rest of the widgets
      body: BlocProvider<LoginBloc>(
        bloc: _loginBloc,
        child: LoginForm(),
      ),
    );
  }



  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }
}
