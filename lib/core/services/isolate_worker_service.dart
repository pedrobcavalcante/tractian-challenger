import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:tractian/features/asset/domain/entities/asset.dart';
import 'package:tractian/features/asset/domain/entities/location.dart';
import 'package:tractian/features/asset/domain/entities/tree_node.dart';
import 'package:tractian/shared/domain/enums/item_type.dart';
import 'package:tractian/shared/domain/enums/sensor_status.dart';

class IsolateWorkerService {
  Future<List<TreeNode>> processFilters({
    required List<TreeNode> nodes,
    required String filterValue,
    required bool criticalFilter,
    required bool energyFilter,
    required bool operationalFilter,
  }) async {
    final params = FilterParams(
      nodes: nodes,
      filterValue: filterValue,
      criticalFilter: criticalFilter,
      energyFilter: energyFilter,
      operationalFilter: operationalFilter,
    );

    return compute(_filterNodesIsolate, params);
  }

  Future<List<TreeNode>> buildTree({
    required List<Location> locations,
    required List<Asset> assets,
  }) async {
    final params = BuildParams(locations: locations, assets: assets);

    return compute(_buildTreeIsolate, params);
  }
}

class FilterParams {
  final List<TreeNode> nodes;
  final String filterValue;
  final bool criticalFilter;
  final bool energyFilter;
  final bool operationalFilter;

  FilterParams({
    required this.nodes,
    required this.filterValue,
    required this.criticalFilter,
    required this.energyFilter,
    required this.operationalFilter,
  });
}

class BuildParams {
  final List<Location> locations;
  final List<Asset> assets;

  BuildParams({required this.locations, required this.assets});
}

List<TreeNode> _filterNodesIsolate(FilterParams params) {
  return params.nodes.fold<List<TreeNode>>([], (filtered, node) {
    final processedNode = _processNodeHierarchically(
      node,
      params.filterValue,
      params.criticalFilter,
      params.energyFilter,
      params.operationalFilter,
    );
    if (processedNode != null) {
      filtered.add(processedNode);
    }
    return filtered;
  });
}

TreeNode? _processNodeHierarchically(
  TreeNode node,
  String filterValue,
  bool criticalFilter,
  bool energyFilter,
  bool operationalFilter,
) {
  final bool nodeMatches = _nodeMatchesFilters(
    node,
    filterValue,
    criticalFilter,
    energyFilter,
    operationalFilter,
  );

  if (nodeMatches) {
    return node.copyWith(isExpanded: node.isExpanded);
  }

  final List<TreeNode> matchingChildren = [];
  for (final child in node.children) {
    final processedChild = _processNodeHierarchically(
      child,
      filterValue,
      criticalFilter,
      energyFilter,
      operationalFilter,
    );
    if (processedChild != null) {
      matchingChildren.add(processedChild);
    }
  }

  if (matchingChildren.isNotEmpty) {
    return node.copyWith(
      children: matchingChildren,
      isExpanded: node.isExpanded,
    );
  }

  return null;
}

bool _nodeMatchesFilters(
  TreeNode node,
  String filterValue,
  bool criticalFilter,
  bool energyFilter,
  bool operationalFilter,
) {
  if (filterValue.isNotEmpty &&
      !node.name.toLowerCase().contains(filterValue.toLowerCase())) {
    return false;
  }

  if (criticalFilter && node.status != SensorStatus.critico) {
    return false;
  }

  if (energyFilter && node.sensorType != "energy") {
    return false;
  }

  if (operationalFilter && node.status != SensorStatus.operacional) {
    return false;
  }

  return true;
}

List<TreeNode> _buildTreeIsolate(BuildParams params) {
  if (params.locations.isEmpty && params.assets.isEmpty) {
    return [];
  }

  final Map<String, TreeNode> nodeMap = <String, TreeNode>{};
  final Set<String> childIds = <String>{};

  for (final location in params.locations) {
    final node = location.toTreeNode();
    nodeMap[node.id] = node;
    if (node.parentId != null) {
      childIds.add(node.id);
    }
  }

  for (final asset in params.assets) {
    final node = asset.toTreeNode();
    nodeMap[node.id] = node;
    final parentRef = node.parentId ?? node.locationId;
    if (parentRef != null) {
      childIds.add(node.id);
    }
  }

  for (final node in nodeMap.values) {
    final parentId = node.parentId ?? node.locationId;
    if (parentId != null && nodeMap.containsKey(parentId)) {
      final parent = nodeMap[parentId]!;
      parent.children.add(node);
      if (parent.type == ItemType.componente &&
          node.type == ItemType.componente) {
        parent.type = ItemType.ativo;
      }
    }
  }

  final rootNodes =
      nodeMap.values.where((node) => !childIds.contains(node.id)).toList();
  rootNodes.sort((a, b) => a.name.compareTo(b.name));
  return rootNodes;
}
