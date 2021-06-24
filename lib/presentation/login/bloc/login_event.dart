import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/data/login/remote/dto/login_request.dart';

abstract class LoginEvent extends Equatable{}

class LoginEventDoLogin implements LoginEvent {
  final LoginRequest loginRequest;

  LoginEventDoLogin({required this.loginRequest});

  @override
  List<Object?> get props => [loginRequest];

  @override
  bool? get stringify => false;

}