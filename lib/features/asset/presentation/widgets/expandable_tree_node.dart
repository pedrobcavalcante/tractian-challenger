import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tractian/core/constants/constants.dart';
import 'package:tractian/shared/domain/enums/sensor_status.dart';
import 'package:tractian/shared/presentation/widgets/icon_type.dart';
import 'package:tractian/features/asset/domain/entities/tree_node.dart';

class ExpandableTreeNode extends StatefulWidget {
  final TreeNode node;
  final List<Widget>? children;

  const ExpandableTreeNode({super.key, required this.node, this.children});

  @override
  ExpandableTreeNodeState createState() => ExpandableTreeNodeState();
}

class ExpandableTreeNodeState extends State<ExpandableTreeNode>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Constants.animationDuration,
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0.75,
      end: 1,
    ).animate(_controller);

    // Inicializa a animação baseada no estado do nó
    if (widget.node.isExpanded) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      widget.node.toggleExpansion();
      widget.node.isExpanded ? _controller.forward() : _controller.reverse();
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
            onTap:
                widget.children == null || widget.children!.isEmpty
                    ? null
                    : _toggleExpansion,
            child: Row(
              children: [
                widget.children == null || widget.children!.isEmpty
                    ? const SizedBox(width: 4)
                    : RotationTransition(
                      turns: _rotationAnimation,
                      child: SvgPicture.asset(
                        'assets/icons/arrow.svg',
                        width: 8,
                        height: 8,
                      ),
                    ),
                const SizedBox(width: 8),
                ItemTypeIcon(itemType: widget.node.type),
                const SizedBox(width: 8),
                Flexible(
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
                    ? Icon(
                      Icons.bolt_rounded,
                      color: const Color(0xFF52C41A),
                      size: 16,
                    )
                    : widget.node.status == SensorStatus.critico
                    ? Icon(Icons.circle, color: Colors.red, size: 8)
                    : const SizedBox(),
              ],
            ),
          ),
        ),
        AnimatedSwitcher(
          duration: Constants.animationDuration,
          child:
              widget.node.isExpanded && widget.children != null
                  ? Padding(
                    padding: const EdgeInsets.only(left: 20.0),
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
