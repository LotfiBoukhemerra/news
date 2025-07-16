import 'package:equatable/equatable.dart';

// Type: The return type of the use case (e.g., List<ArticleEntity>)
// Params: The parameters required by the use case (e.g., page, category)
abstract class UseCase<Type, Params> {
  Future<Type> call({required Params params});
}

// A simple class for use cases that don't require any parameters.
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
