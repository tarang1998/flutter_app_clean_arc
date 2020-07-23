
import 'package:brew_app_clean_arc/features/brew/domain/entities/userdata.dart';
import 'package:brew_app_clean_arc/features/brew/domain/repositories/brew_repository.dart';

class GetUserBrewData {
  final BrewRepository repository;

  GetUserBrewData(this.repository);


  Stream<UserData> call(String uid)  {
    return repository.userData(uid);
  }
}

