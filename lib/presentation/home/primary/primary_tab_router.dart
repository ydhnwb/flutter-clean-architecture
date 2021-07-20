import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/main.dart';
import 'package:flutter_clean_architecture/presentation/create_product/create_product_page.dart';
import 'package:flutter_clean_architecture/presentation/detail/detail_page.dart';
import 'package:flutter_clean_architecture/presentation/home/primary/primary_tab.dart';

class PrimaryTabRouter {
  static const PRIMARY_TAB_ROOT = "/";
  static const PRIMARY_TAB_CREATE = "/create";
  static const PRIMARY_TAB_DETAIL = "/detail";


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PRIMARY_TAB_ROOT:
        return MaterialPageRoute(builder: (_) => PrimaryTab(primaryTabBloc: sl()));
      case PRIMARY_TAB_CREATE:
        return MaterialPageRoute(builder: (_) => CreateProductPage(bloc: sl(),));
      case PRIMARY_TAB_DETAIL:
        String productId = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => DetailPage(productId: productId, bloc: sl()));
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(body: Center(child: Text("No route"))));
    }
  }
}