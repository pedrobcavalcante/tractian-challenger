import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tractian/features/asset/domain/entities/tree_node.dart';
import 'package:tractian/shared/domain/enums/sensor_status.dart';
import 'package:tractian/shared/presentation/widgets/icon_type.dart';

class TreeNodeItem extends StatefulWidget {
  final TreeNode node;
  final int level;
  final bool hasChildren;
  final VoidCallback? onToggle;

  const TreeNodeItem({
    super.key,
    required this.node,
    required this.level,
    required this.hasChildren,
    this.onToggle,
  });

  @override
  TreeNodeItemState createState() => TreeNodeItemState();
}

class TreeNodeItemState extends State<TreeNodeItem>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late final AnimationController _controller;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0.75,
      end: 1,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      _isExpanded ? _controller.forward() : _controller.reverse();
    });
    widget.onToggle?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: widget.level * 16.0),
      child: SizedBox(
        height: 30,
        child: GestureDetector(
          onTap: widget.hasChildren ? _toggleExpansion : null,
          child: Row(
            children: [
              widget.hasChildren
                  ? RotationTransition(
                      turns: _rotationAnimation,
                      child: SvgPicture.asset(
                        'assets/icons/arrow.svg',
                        width: 8,
                        height: 8,
                      ),
                    )
                  : const SizedBox(width: 8),
              const SizedBox(width: 8),
              ItemTypeIcon(itemType: widget.node.type),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.node.name,
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF17192D),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                ),
              ),
              const SizedBox(width: 8),
              widget.node.status == SensorStatus.operacional
                  ? const Icon(
                      Icons.bolt_rounded,
                      color: Color(0xFF52C41A),
                      size: 16,
                    )
                  : widget.node.status == SensorStatus.critico
                      ? const Icon(
                          Icons.circle,
                          color: Colors.red,
                          size: 8,
                        )
                      : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
