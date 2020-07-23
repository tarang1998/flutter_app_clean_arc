



import 'package:brew_app_clean_arc/core/usecase/usecase.dart';
import 'package:brew_app_clean_arc/features/brew/domain/repositories/brew_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class UpdateUserData implements UseCase<void, Params> {
  final BrewRepository repository;

  UpdateUserData(this.repository);

  @override
  Future<void> call(Params params) async {
    return await repository.updateUserData(params.uid,params.sugars,params.name,params.strength);
  }
}

class Params extends Equatable {
  final String uid;
  final String sugars;
  final String name;
  final int strength;

  Params({@required this.uid,
          @required this.sugars,
          @required this.name,
          @required this.strength
  });

  @override
  List<Object> get props => [uid,sugars,name,strength];
}
