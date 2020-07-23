



import 'package:brew_app_clean_arc/core/usecase/usecase.dart';
import 'package:brew_app_clean_arc/features/login_signup/domain/repository/login_signup_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class SignInWithCredentials implements UseCase<void, Params> {
  final LoginSignUpRepository repository;

  SignInWithCredentials(this.repository);

  @override
  Future<void> call(Params params) async {
    return await repository.signInWithCredentials(params.email,params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  Params({@required this.email,@required this.password});

  @override
  List<Object> get props => [email,password];
}
