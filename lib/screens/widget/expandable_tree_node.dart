import 'package:flutter/material.dart';

class ExpandableTreeNode extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<ExpandableTreeNode> children;
  final double indent;

  const ExpandableTreeNode({
    super.key,
    required this.title,
    required this.icon,
    this.children = const [],
    this.indent = 0.0,
  });

  @override
  ExpandableTreeNodeState createState() => ExpandableTreeNodeState();
}

class ExpandableTreeNodeState extends State<ExpandableTreeNode> {
  bool _isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleExpansion,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: widget.indent),
                child: Icon(
                  _isExpanded ? Icons.arrow_drop_down : Icons.arrow_right,
                  size: 24,
                ),
              ),
              const SizedBox(width: 8),
              Icon(widget.icon),
              const SizedBox(width: 8),
              Text(
                widget.title,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        if (_isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              children: widget.children.map((child) {
                return Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: child,
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
