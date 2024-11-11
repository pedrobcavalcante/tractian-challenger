import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssetScreen extends StatelessWidget {
  const AssetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String id = Get.arguments['id'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Assets for Unit $id'),
      ),
      body: Center(
        child: Text('Exibindo os assets para o ID: $id'),
      ),
    );
  }
}
