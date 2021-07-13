import 'package:equatable/equatable.dart';

abstract class PrimaryTabEvent extends Equatable{}

class PrimaryTabEventGetProducts implements PrimaryTabEvent {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;

}