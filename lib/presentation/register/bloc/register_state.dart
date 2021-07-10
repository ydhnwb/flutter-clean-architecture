import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/domain/register/entity/register_entity.dart';
import 'package:flutter_clean_architecture/presentation/register/register.page.dart';

abstract class RegisterPageState extends Equatable{}


class RegisterPageStateInit implements RegisterPageState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;

}

class RegisterPageStateLoading implements RegisterPageState {
  final bool isLoading;

  RegisterPageStateLoading({ required this.isLoading });

  @override
  List<Object?> get props => [isLoading];

  @override
  bool? get stringify => false;

}

class RegisterPageStateSuccess implements RegisterPageState {
  final RegisterEntity registerEntity;

  RegisterPageStateSuccess({ required this.registerEntity });

  @override
  List<Object?> get props => [registerEntity];

  @override
  bool? get stringify => false;
  
}

class RegisterPageStateError implements RegisterPageState{
  final String message;

  RegisterPageStateError({required this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => false;
  
}