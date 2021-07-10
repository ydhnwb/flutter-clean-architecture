import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/data/register/remote/dto/register_request.dart';

abstract class RegisterPageEvent extends Equatable{}


class RegisterPageEventDoRegister implements RegisterPageEvent {
  final RegisterRequest registerRequest;

  RegisterPageEventDoRegister({ required this.registerRequest });

  @override
  List<Object?> get props => [registerRequest];

  @override
  bool? get stringify => false;
  
}