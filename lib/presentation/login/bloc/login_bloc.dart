import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/data/login/remote/dto/login_request.dart';
import 'package:flutter_clean_architecture/domain/login/repository/login_repository.dart';
import 'package:flutter_clean_architecture/domain/login/usecase/login_usecase.dart';
import 'package:flutter_clean_architecture/presentation/login/bloc/login_event.dart';
import 'package:flutter_clean_architecture/presentation/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginStateInit());

  Stream<LoginState> _setIsLoading(bool isLoading) async* {
    print("ssss");
    print(isLoading);
    yield LoginStateLoading(isLoading: isLoading);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if(event is LoginEventDoLogin){
      yield* login(event.loginRequest);
    }
  }

  Stream<LoginState> login(LoginRequest loginRequest) async* {
    yield* _setIsLoading(true);
    var result = await loginUseCase.login(loginRequest);
    yield* _setIsLoading(false);
    yield* result.fold(
      (l) async* {
        yield LoginStateSuccessLogin(loginEntity: l);
      }, 
      (r) async* {
        yield LoginStateErrorLogin(message: r.message);
      }
    );
  }

}