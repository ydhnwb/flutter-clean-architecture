import 'package:equatable/equatable.dart';

abstract class CreateProductPageState extends Equatable{}

class CreateProductPageStateInit implements CreateProductPageState{
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class CreateProductPageStateIsLoading implements CreateProductPageState {
  final bool isLoading;

  CreateProductPageStateIsLoading({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];

  @override
  bool? get stringify => false;
}

class CreateProductPageStateSuccessCreate implements CreateProductPageState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;

}

class CreateProductPageStateShowMessage implements CreateProductPageState {
  final String message;
  CreateProductPageStateShowMessage({required this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => false;
}