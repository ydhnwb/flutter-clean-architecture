import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/data/common/interceptor/request_interceptor.dart';
import 'package:flutter_clean_architecture/data/common/module/network_module.dart';
import 'package:flutter_clean_architecture/data/common/module/shared_pref_module.dart';
import 'package:flutter_clean_architecture/data/login/remote/api/login_api.dart';
import 'package:flutter_clean_architecture/data/login/remote/api/login_api_impl.dart';
import 'package:flutter_clean_architecture/data/login/repository/login_repository_impl.dart';
import 'package:flutter_clean_architecture/domain/login/repository/login_repository.dart';
import 'package:flutter_clean_architecture/domain/login/usecase/login_usecase.dart';
import 'package:flutter_clean_architecture/presentation/home/home_page.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
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
  sl.registerLazySingleton<Dio>(
      () => NetworkModule(requestInterceptor: sl()).provideDio(),
  );

  //datasource
  sl.registerLazySingleton<LoginApi>(
      () => LoginApiImpl(dio: sl())
  );

  //repositories
  sl.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(loginApi: sl())
  );

  //use cases
  sl.registerLazySingleton(
      () => LoginUseCase(loginRepository: sl())
  );


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
            title: "Flutter clean architecture",
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomePage(loginRepository: sl<LoginRepository>()),
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

class XXX extends StatelessWidget {
  const XXX({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HHH"),),
      body: Container(
        child: Text("hello world"),
      ),
    );
  }
}
