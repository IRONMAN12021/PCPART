import 'package:flutter/material.dart';

class ExpandableInfoCard extends StatefulWidget {
  final String title;
  final String description;
  final Widget? child;

  const ExpandableInfoCard({
    super.key,
    required this.title,
    required this.description,
    this.child,
  });

  @override
  State<ExpandableInfoCard> createState() => _ExpandableInfoCardState();
}

class _ExpandableInfoCardState extends State<ExpandableInfoCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(widget.title),
            subtitle: Text(
              widget.description,
              maxLines: isExpanded ? null : 2,
              overflow: isExpanded ? null : TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () => setState(() => isExpanded = !isExpanded),
            ),
          ),
          if (isExpanded && widget.child != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: widget.child!,
            ),
        ],
      ),
    );
  }
} 