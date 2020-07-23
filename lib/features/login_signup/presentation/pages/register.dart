import 'package:brew_app_clean_arc/features/login_signup/presentation/bloc/bloc_register/bloc.dart';
import 'package:brew_app_clean_arc/features/login_signup/presentation/widgets/register_widgets/register_form.dart';
import 'package:brew_app_clean_arc/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  //final UserRepository _userRepository;

//  RegisterScreen({Key key, @required UserRepository userRepository})
//      : assert(userRepository != null),
//        _userRepository = userRepository,
//        super(key: key);

  RegisterScreen({Key key});  // key????

  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterBloc _registerBloc;


  @override
  void initState() {
    super.initState();
    _registerBloc = sl<RegisterBloc>();
//        RegisterBloc(
//      userRepository: widget._userRepository,
//    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey[100],
      appBar: AppBar(
          title: Text('Register'),
        backgroundColor: Colors.grey[900],

      ),
      body: Center(
        child: BlocProvider<RegisterBloc>(
         bloc: _registerBloc,
          child: RegisterForm(),
        ),
      ),
    );
  }



  @override
  void dispose() {
    _registerBloc.dispose();
    super.dispose();
  }
}

