import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/data/common/interceptor/request_interceptor.dart';
import 'package:flutter_clean_architecture/data/common/module/network_module.dart';
import 'package:flutter_clean_architecture/data/common/module/shared_pref_module.dart';
import 'package:flutter_clean_architecture/data/login/remote/api/login_api.dart';
import 'package:flutter_clean_architecture/data/login/remote/api/login_api_impl.dart';
import 'package:flutter_clean_architecture/data/login/repository/login_repository_impl.dart';
import 'package:flutter_clean_architecture/data/product/remote/api/product_api.dart';
import 'package:flutter_clean_architecture/data/product/remote/api/product_api_impl.dart';
import 'package:flutter_clean_architecture/data/product/repository/product_repository_impl.dart';
import 'package:flutter_clean_architecture/data/register/remote/api/register_api.dart';
import 'package:flutter_clean_architecture/data/register/remote/api/register_api_impl.dart';
import 'package:flutter_clean_architecture/data/register/repository/register_repository_impl.dart';
import 'package:flutter_clean_architecture/domain/login/repository/login_repository.dart';
import 'package:flutter_clean_architecture/domain/login/usecase/login_usecase.dart';
import 'package:flutter_clean_architecture/domain/product/repository/create_product_repository.dart';
import 'package:flutter_clean_architecture/domain/product/repository/delete_product_repository.dart';
import 'package:flutter_clean_architecture/domain/product/repository/get_product_repository.dart';
import 'package:flutter_clean_architecture/domain/product/repository/update_product_repository.dart';
import 'package:flutter_clean_architecture/domain/product/usecase/create_product_usecase.dart';
import 'package:flutter_clean_architecture/domain/product/usecase/delete_product_usecase.dart';
import 'package:flutter_clean_architecture/domain/product/usecase/find_all_product_usecase.dart';
import 'package:flutter_clean_architecture/domain/product/usecase/find_product_by_id_usecase.dart';
import 'package:flutter_clean_architecture/domain/product/usecase/update_product_usecase.dart';
import 'package:flutter_clean_architecture/domain/register/repository/register_repository.dart';
import 'package:flutter_clean_architecture/domain/register/usecase/register_usecase.dart';
import 'package:flutter_clean_architecture/presentation/common/infra/router.dart';
import 'package:flutter_clean_architecture/presentation/create_product/bloc/create_product_bloc.dart';
import 'package:flutter_clean_architecture/presentation/detail/bloc/detail_product_bloc.dart';
import 'package:flutter_clean_architecture/presentation/home/primary/bloc/primary_tab_bloc.dart';
import 'package:flutter_clean_architecture/presentation/login/bloc/login_bloc.dart';
import 'package:flutter_clean_architecture/presentation/register/bloc/register_bloc.dart';
import 'package:flutter_clean_architecture/presentation/splash/splash.page.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
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
  sl.registerLazySingleton<ProductApi>(() => ProductApiImpl(dio: sl()));

  //repositories
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(loginApi: sl()));
  sl.registerLazySingleton<RegisterRepository>(() => RegisterRepositoryImpl(registerApi: sl()));
  sl.registerLazySingleton<GetProductRepository>(() => ProductRepositoryImpl(productApi: sl()));
  sl.registerLazySingleton<CreateProductRepository>(() => ProductRepositoryImpl(productApi: sl()));
  sl.registerLazySingleton<UpdateProductRepository>(() => ProductRepositoryImpl(productApi: sl()));
  sl.registerLazySingleton<DeleteProductRepository>(() => ProductRepositoryImpl(productApi: sl()));

  //use cases
  sl.registerLazySingleton(() => LoginUseCase(loginRepository: sl()));
  sl.registerLazySingleton(() => RegisterUseCase(registerRepository: sl()));
  sl.registerLazySingleton(() => FindAllProductUseCase(getProductRepository: sl()));
  sl.registerLazySingleton(() => FindProductByIdUseCase(getProductRepository: sl()));
  sl.registerLazySingleton(() => CreateProductUseCase(createProductRepository: sl()));
  sl.registerLazySingleton(() => UpdateProductUseCase(updateProductRepository: sl()));
  sl.registerLazySingleton(() => DeleteProductUseCase(deleteProductRepository: sl()));

  //blocs
  sl.registerFactory(() => LoginBloc(
    loginUseCase: sl(),
    sharedPreferenceModule: sl()
  ));

  sl.registerFactory(() => RegisterBloc(
      registerUseCase: sl(),
      sharedPreferenceModule: sl()
  ));

  sl.registerFactory(() => PrimaryTabBloc(findAllProductUseCase: sl()));

  sl.registerFactory(() => DetailProductPageBloc(
    findProductByIdUseCase: sl(), 
    updateProductUseCase: sl(), 
    deleteProductUseCase: sl()
  ));

  sl.registerFactory(() => CreateProductPageBloc(createProductUseCase: sl()));


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
