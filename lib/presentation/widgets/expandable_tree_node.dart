import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../asset_screen/enums/item_type.dart';
import '../asset_screen/enums/sensor_status.dart';
import 'icon_type.dart';

class ExpandableTreeNode extends StatefulWidget {
  final String title;
  final ItemType itemType;
  final SensorStatus? sensorStatus;
  final Widget? child;

  const ExpandableTreeNode({
    super.key,
    required this.title,
    required this.itemType,
    this.child,
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
            onTap: widget.child == null ? null : _toggleExpansion,
            child: Row(
              children: [
                widget.child == null
                    ? const SizedBox(width: 14)
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
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF17192D),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                ),
                const SizedBox(width: 8),
                widget.sensorStatus == SensorStatus.energia
                    ? Icon(Icons.bolt_rounded,
                        color: const Color(0xFF52C41A), size: 16)
                    : Icon(Icons.circle, color: Colors.red, size: 8),
              ],
            ),
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: _isExpanded
              ? Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: SizeTransition(
                    sizeFactor: _controller,
                    axisAlignment: -1,
                    child: widget.child,
                  ),
                )
              : null,
        ),
      ],
    );
  }
}
