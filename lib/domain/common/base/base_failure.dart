import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  
  Failure({required this.message});
  
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure{
  final String message;

  ServerFailure({required this.message}) : super(message: message);
}
class CacheFailure extends Failure{
  final String message;

  CacheFailure({required this.message}) : super(message: message);
}