
import 'package:brew_app_clean_arc/core/usecase/usecase.dart';
import 'package:brew_app_clean_arc/features/login_signup/domain/repository/login_signup_repository.dart';

class IsSignedIn implements UseCase<bool, NoParams> {
  final LoginSignUpRepository repository;

  IsSignedIn(this.repository);

  @override
  Future<bool> call(NoParams params) async {
    return await repository.isSignedIn();
  }
}

