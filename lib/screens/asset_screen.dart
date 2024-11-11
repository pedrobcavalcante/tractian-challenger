import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/assets_app_bar.dart';
import 'asset_screen/enums/item_type.dart';
import 'asset_screen/enums/sensor_status.dart';
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
                    itemType: ItemType.local,
                    sensorStatus: SensorStatus.energia,
                    child: ExpandableTreeNode(
                      title: 'CHARCOAL STORAGE SECTOR',
                      itemType: ItemType.local,
                      sensorStatus: SensorStatus.energia,
                      child: ExpandableTreeNode(
                        title: 'CONVEYOR BELT ASSEMBLY',
                        itemType: ItemType.componente,
                        sensorStatus: SensorStatus.critico,
                        child: ExpandableTreeNode(
                          title: 'MOTOR TC01 COAL UNLOADING AF02',
                          itemType: ItemType.ativo,
                          sensorStatus: SensorStatus.critico,
                          child: ExpandableTreeNode(
                            title: 'MOTOR RT COAL AF01',
                            itemType: ItemType.ativo,
                            sensorStatus: SensorStatus.critico,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ExpandableTreeNode(
                    title: 'Fan - External',
                    itemType: ItemType.ativo,
                    sensorStatus: SensorStatus.energia,
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
