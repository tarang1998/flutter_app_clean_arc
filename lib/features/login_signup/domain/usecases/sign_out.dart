
import 'package:brew_app_clean_arc/core/usecase/usecase.dart';
import 'package:brew_app_clean_arc/features/login_signup/domain/repository/login_signup_repository.dart';

class SignOut implements UseCase<void, NoParams> {
  final LoginSignUpRepository repository;

  SignOut(this.repository);

  @override
  Future<void> call(NoParams params) async {
    return await repository.signOut();
  }
}

