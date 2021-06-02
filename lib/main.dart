import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/data/login/repository/login_repository_impl.dart';
import 'package:flutter_clean_architecture/domain/login/repository/login_repository.dart';
import 'package:flutter_clean_architecture/domain/login/usecase/login_usecase.dart';
import 'package:flutter_clean_architecture/presentation/home/home_page.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<LoginRepository>(() {
    return LoginRepositoryImpl();
  });


  //use cases
  sl.registerLazySingleton(() => LoginUseCase(loginRepository: sl()));
}

void main() async {
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(loginRepository: sl<LoginRepository>()),
    );
  }
}