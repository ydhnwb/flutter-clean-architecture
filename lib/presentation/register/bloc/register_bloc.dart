import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/data/common/module/shared_pref_module.dart';
import 'package:flutter_clean_architecture/data/register/remote/dto/register_request.dart';
import 'package:flutter_clean_architecture/domain/register/usecase/register_usecase.dart';
import 'package:flutter_clean_architecture/presentation/register/bloc/register_event.dart';
import 'package:flutter_clean_architecture/presentation/register/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterPageEvent, RegisterPageState> {
  final RegisterUseCase registerUseCase;
  final SharedPreferenceModule sharedPreferenceModule;

  RegisterBloc({ required this.registerUseCase, required this.sharedPreferenceModule }) : super(RegisterPageStateInit());
  
  @override
  Stream<RegisterPageState> mapEventToState(RegisterPageEvent event) async* {
    if(event is RegisterPageEventDoRegister){
      yield* _register(event.registerRequest);
    }
  }

  Stream<RegisterPageState> _setIsLoading(bool isLoading) async* {
    yield RegisterPageStateLoading(isLoading: isLoading);
  }

  Stream<RegisterPageState> _register(RegisterRequest registerRequest) async* {
    yield* _setIsLoading(true);
    var result = await registerUseCase.invoke(registerRequest);
    yield* _setIsLoading(false);
    yield* result.fold(
        (l) async* {
          sharedPreferenceModule.saveUserData(jsonEncode(l));
          yield RegisterPageStateSuccess(registerEntity: l);
        },
        (r) async* {
          yield RegisterPageStateError(message: r.message);
        }
    );
  }

}