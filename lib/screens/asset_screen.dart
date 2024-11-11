import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/assets_app_bar.dart';

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
            // Campo de Busca
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Buscar Ativo ou Local',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Botões de Filtro
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Implementar o filtro de sensor de energia
                    },
                    icon: const Icon(Icons.flash_on),
                    label: const Text('Sensor de Energia'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2188FF),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Implementar o filtro crítico
                    },
                    icon: const Icon(Icons.error_outline),
                    label: const Text('Crítico'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
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
