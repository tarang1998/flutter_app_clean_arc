
import 'package:brew_app_clean_arc/features/login_signup/presentation/pages/register.dart';
import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  //final UserRepository _userRepository;

//  CreateAccountButton({Key key, @required UserRepository userRepository})
//      : assert(userRepository != null),
//        _userRepository = userRepository,
//        super(key: key);

  CreateAccountButton({Key key});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Create an Account',
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            //we're pushing a new route in response to the button press to the RegisterScreen
            //return RegisterScreen(userRepository: _userRepository);
            return RegisterScreen();
          }),
        );
      },
    );
  }
}
