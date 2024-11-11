import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/assets_app_bar.dart';
import 'widget/filter_buttons.dart';
import 'widget/search_field.dart';
import 'widget/expandable_tree_node.dart';

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
            const SizedBox(height: 16),
            FilterButtons(),
            const SizedBox(height: 16),

            // Estrutura da Árvore de Ativos
            Expanded(
              child: ListView(
                children: [
                  ExpandableTreeNode(
                    title: 'PRODUCTION AREA - RAW MATERIAL',
                    icon: Icons.location_on,
                    indent: 0,
                    children: [
                      ExpandableTreeNode(
                        title: 'CHARCOAL STORAGE SECTOR',
                        icon: Icons.location_on,
                        indent: 16,
                        children: [
                          ExpandableTreeNode(
                            title: 'CONVEYOR BELT ASSEMBLY',
                            icon: Icons.widgets,
                            indent: 32,
                            children: [
                              ExpandableTreeNode(
                                title: 'MOTOR TC01 COAL UNLOADING AF02',
                                icon: Icons.widgets,
                                indent: 48,
                                children: [
                                  ExpandableTreeNode(
                                    title: 'MOTOR RT COAL AF01',
                                    icon: Icons.sensors,
                                    indent: 64,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  ExpandableTreeNode(
                    title: 'Fan - External',
                    icon: Icons.sensors,
                    indent: 0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
