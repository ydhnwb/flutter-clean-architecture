import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final int code;
  final String message;
  
  Failure({required this.message, required this.code});
  
  @override
  List<Object?> get props => [];
}

class BaseFailure extends Failure {
  final int code;
  final String message;

  BaseFailure({required this.message, required this.code}) : super(message: message, code: code);


}

// class ServerFailure extends Failure{
//   final String message;

//   ServerFailure({required this.message}) : super(message: message);
// }
// class CacheFailure extends Failure{
//   final String message;

//   CacheFailure({required this.message}) : super(message: message);
// }