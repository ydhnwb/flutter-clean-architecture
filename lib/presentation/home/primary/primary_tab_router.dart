import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/home/primary/primary_tab.dart';
import 'package:flutter_clean_architecture/presentation/home/primary/primary_tab_detail.dart';

class PrimaryTabRouter {
  static const PRIMARY_TAB_ROOT = "/";
  static const PRIMARY_TAB_DETAIL = "/detail";


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PRIMARY_TAB_ROOT:
        return MaterialPageRoute(builder: (_) => PrimaryTab());
      case PRIMARY_TAB_DETAIL:
        return MaterialPageRoute(builder: (_) => PrimaryTabDetail());
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(body: Center(child: Text("No route"))));
    }
  }
}