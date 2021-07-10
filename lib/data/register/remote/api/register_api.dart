import 'package:flutter_clean_architecture/data/register/remote/dto/register_request.dart';
import 'package:flutter_clean_architecture/domain/register/entity/register_entity.dart';

abstract class RegisterApi {
  Future<RegisterEntity> register(RegisterRequest registerRequest);
}