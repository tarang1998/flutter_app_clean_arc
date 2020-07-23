
import 'package:brew_app_clean_arc/core/usecase/usecase.dart';
import 'package:brew_app_clean_arc/features/login_signup/domain/entity/user.dart';
import 'package:brew_app_clean_arc/features/login_signup/domain/repository/login_signup_repository.dart';

class GetUser implements UseCase<User, NoParams> {
  final LoginSignUpRepository repository;

  GetUser(this.repository);

  @override
  Future<User> call(NoParams params) async {
    return await repository.getUser();
  }
}

