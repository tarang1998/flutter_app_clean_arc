import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Brew extends Equatable {
  final String name;
  final String sugar;
  final int strength;

  Brew({
    @required this.name,
    @required this.sugar,
    @required this.strength,
  }) : super([name, sugar, strength]);
}