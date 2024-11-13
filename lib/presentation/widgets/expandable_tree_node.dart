import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/enums/item_type.dart';
import '../../domain/enums/sensor_status.dart';
import 'icon_type.dart';

class ExpandableTreeNode extends StatefulWidget {
  final String title;
  final ItemType itemType;
  final SensorStatus? sensorStatus;
  final List<Widget>? children;

  const ExpandableTreeNode({
    super.key,
    required this.title,
    required this.itemType,
    this.children,
    this.sensorStatus,
  });

  @override
  ExpandableTreeNodeState createState() => ExpandableTreeNodeState();
}

class ExpandableTreeNodeState extends State<ExpandableTreeNode>
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
    _rotationAnimation =
        Tween<double>(begin: 0.75, end: 1).animate(_controller);
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
          child: GestureDetector(
            onTap: widget.children == null || widget.children!.isEmpty
                ? null
                : _toggleExpansion,
            child: Row(
              children: [
                widget.children == null || widget.children!.isEmpty
                    ? const SizedBox()
                    : RotationTransition(
                        turns: _rotationAnimation,
                        child: SvgPicture.asset(
                          'assets/icons/arrow.svg',
                          width: 8,
                          height: 8,
                        ),
                      ),
                const SizedBox(width: 8),
                ItemTypeIcon(itemType: widget.itemType),
                const SizedBox(width: 8),
                Text(
                  widget.title,
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
                const SizedBox(width: 8),
                widget.sensorStatus == SensorStatus.operacional
                    ? Icon(Icons.bolt_rounded,
                        color: const Color(0xFF52C41A), size: 16)
                    : widget.sensorStatus == SensorStatus.critico
                        ? Icon(Icons.circle, color: Colors.red, size: 8)
                        : const SizedBox(),
              ],
            ),
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: _isExpanded && widget.children != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.children!,
                  ),
                )
              : null,
        ),
      ],
    );
  }
}
