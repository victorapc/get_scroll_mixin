import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_scroll_mixin/pages/user_list_controller.dart';
import 'package:get_scroll_mixin/pages/user_list_page.dart';
import 'package:get_scroll_mixin/repositories/user_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Get Scroll Mixin',
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(
            () => Dio(BaseOptions(baseUrl: 'http://192.168.0.108:8080/')),
            fenix: true);
        Get.lazyPut(() => UserRepository(dio: Get.find()), fenix: true);
      }),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      getPages: [
        GetPage(
          name: '/',
          binding: BindingsBuilder.put(() => UserListController()),
          page: () => const UserListPage(),
        ),
      ],
    );
  }
}
