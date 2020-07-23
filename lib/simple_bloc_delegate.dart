
//One added bonus of using bloc is that we can have access to all Transitions in one place.
// It's fairly common in large applications to have many blocs managing different parts of the application's state.
//If we want to be able to do something in response to all Transitions we can simply create our own BlocDelegate which we have named SimpleBlocDelegate.
//In order to use our SimpleBlocDelegate, we just need to tweak our main function to set the BlocSupervisor's delegate to our instance of SimpleBlocDelegate


import 'package:bloc/bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print(error);
  }

  @override
  void onTransition(Transition transition) {
    super.onTransition(transition);
    print(transition);
  }
}
