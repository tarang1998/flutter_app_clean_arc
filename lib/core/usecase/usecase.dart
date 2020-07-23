import 'package:equatable/equatable.dart';



// included in this abstract base class method definition.
abstract class UseCase<Type,Params> {
  Future<Type> call(Params params);
}

// This will be used by the code calling the use case whenever the use case
// doesn't accept any parameters.
class NoParams extends Equatable {}