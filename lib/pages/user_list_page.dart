import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_scroll_mixin/pages/user_list_controller.dart';

class UserListPage extends StatelessWidget {
  final controller = Get.find<UserListController>();

  UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: controller.obx(
        (state) {
          final totalItens = (state?.length ?? 0);
          return ListView.builder(
            controller: controller.scroll,
            itemCount: totalItens + 1,
            itemBuilder: (context, index) {
              if (index == totalItens) {
                return Obx(() {
                  return Visibility(
                    visible: controller.isLoading,
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'Carregando Novos Usuários.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                      ),
                    ),
                  );
                });
              }

              final user = state?[index];
              return ListTile(
                title: Text(
                  user?.name ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  user?.email ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
