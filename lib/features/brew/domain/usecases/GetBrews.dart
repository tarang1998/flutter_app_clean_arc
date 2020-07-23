
import 'package:brew_app_clean_arc/features/brew/domain/entities/brew.dart';
import 'package:brew_app_clean_arc/features/brew/domain/repositories/brew_repository.dart';

class GetBrews {
  final BrewRepository repository;

  GetBrews(this.repository);


  Stream<List<Brew>> call()  {
    return repository.brews;
  }
}

