import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/data/common/interceptor/request_interceptor.dart';
import 'package:flutter_clean_architecture/data/common/module/network_module.dart';
import 'package:flutter_clean_architecture/data/common/module/shared_pref_module.dart';
import 'package:flutter_clean_architecture/data/login/remote/api/login_api.dart';
import 'package:flutter_clean_architecture/data/login/remote/api/login_api_impl.dart';
import 'package:flutter_clean_architecture/data/login/repository/login_repository_impl.dart';
import 'package:flutter_clean_architecture/data/register/remote/api/register_api.dart';
import 'package:flutter_clean_architecture/data/register/remote/api/register_api_impl.dart';
import 'package:flutter_clean_architecture/data/register/repository/register_repository_impl.dart';
import 'package:flutter_clean_architecture/domain/login/repository/login_repository.dart';
import 'package:flutter_clean_architecture/domain/login/usecase/login_usecase.dart';
import 'package:flutter_clean_architecture/domain/register/repository/register_repository.dart';
import 'package:flutter_clean_architecture/domain/register/usecase/register_usecase.dart';
import 'package:flutter_clean_architecture/presentation/common/infra/router.dart';
import 'package:flutter_clean_architecture/presentation/login/bloc/login_bloc.dart';
import 'package:flutter_clean_architecture/presentation/register/bloc/register_bloc.dart';
import 'package:flutter_clean_architecture/presentation/register/register.page.dart';
import 'package:flutter_clean_architecture/presentation/splash/splash.page.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // final SharedPreferences pref = await SharedPreferences.getInstance();
  sl.registerSingletonAsync<SharedPreferences>(() => SharedPreferences.getInstance());

  sl.registerSingletonWithDependencies<SharedPreferenceModule>(
    () => SharedPreferenceModule(pref: sl<SharedPreferences>()),
    dependsOn: [SharedPreferences]
  );

  //interceptor
  sl.registerSingletonWithDependencies<RequestInterceptor>(
      () => RequestInterceptor(pref: sl()),
      dependsOn: [SharedPreferenceModule]
  );

  //module
  sl.registerLazySingleton<Dio>(() => NetworkModule(requestInterceptor: sl()).provideDio());

  //datasource
  sl.registerLazySingleton<LoginApi>(() => LoginApiImpl(dio: sl()));
  sl.registerLazySingleton<RegisterApi>(() => RegisterApiImpl(dio: sl()));

  //repositories
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(loginApi: sl()));
  sl.registerLazySingleton<RegisterRepository>(() => RegisterRepositoryImpl(registerApi: sl()));

  //use cases
  sl.registerLazySingleton(() => LoginUseCase(loginRepository: sl()));
  sl.registerLazySingleton(() => RegisterUseCase(registerRepository: sl()));

  //blocs
  sl.registerFactory(() => LoginBloc(
    loginUseCase: sl(),
    sharedPreferenceModule: sl()
  ));

  sl.registerFactory(() => RegisterBloc(
      registerUseCase: sl(),
      sharedPreferenceModule: sl()
  ));


}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: sl.allReady(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return MaterialApp(
            onGenerateRoute: AppRouter.generateRoute,
            // initialRoute: AppRouter.ROUTE_SPLASH,
            title: "Flutter clean architecture",
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            home: SplashPage(),
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
