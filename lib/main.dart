import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian/core/constants/route_names.dart';
import 'bindings/app_bindings.dart';
import 'core/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tractian App',
      initialBinding: AppBindings(),
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: RoutesPage.splash,
      getPages: AppRoutes.getPages,
    );
  }
}
