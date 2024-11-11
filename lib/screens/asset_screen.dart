import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/assets_app_bar.dart';
import 'widget/filter_buttons.dart';
import 'widget/search_field.dart';

class AssetScreen extends StatelessWidget {
  const AssetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String id = Get.arguments['id'];

    return Scaffold(
      appBar: AssetsAppBar(title: 'Assets'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchField(),

            SizedBox(height: 16),
            FilterButtons(),
            const SizedBox(height: 16),

            // Estrutura da Árvore de Ativos
            Expanded(
              child: ListView(
                children: [
                  _buildTreeNode(
                    title: 'PRODUCTION AREA - RAW MATERIAL',
                    icon: Icons.location_on,
                    children: [
                      _buildTreeNode(
                        title: 'CHARCOAL STORAGE SECTOR',
                        icon: Icons.location_on,
                        children: [
                          _buildTreeNode(
                            title: 'CONVEYOR BELT ASSEMBLY',
                            icon: Icons.widgets,
                            children: [
                              _buildTreeNode(
                                title: 'MOTOR TC01 COAL UNLOADING AF02',
                                icon: Icons.widgets,
                                children: [
                                  _buildTreeNode(
                                    title: 'MOTOR RT COAL AF01',
                                    icon: Icons.sensors,
                                    sensorType: 'vibration',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  _buildTreeNode(
                    title: 'Fan - External',
                    icon: Icons.sensors,
                    sensorType: 'energy',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Função para construir um nó da árvore de ativos
  Widget _buildTreeNode({
    required String title,
    required IconData icon,
    String? sensorType,
    List<Widget> children = const [],
  }) {
    return Theme(
      data: ThemeData(
        iconTheme: IconThemeData(
          color: sensorType == 'energy' ? Colors.green : Colors.blue,
        ),
      ),
      child: ExpansionTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        children: children,
      ),
    );
  }
}
