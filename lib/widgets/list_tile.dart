import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListTileSection extends StatelessWidget {
  final Widget? header;
  final List<Widget> children;

  const ListTileSection({super.key, required this.children, this.header});

  @override
  Widget build(BuildContext context) {
    var body = Container(
      decoration: BoxDecoration(
        color: const Color(0xff353c3e),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
        child: Column(
          children: _buildItem(),
        ),
      ),
    );

    var child = header == null
        ? body
        : Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: header!,
                ),
              ),
              body
            ],
          );
    return Container(margin: const EdgeInsets.only(top: 20), child: child);
  }

  List<Widget> _buildItem() {
    var items = <Widget>[];
    for (var child in children) {
      items.add(child);
      if (child != children.last) {
        items.add(const SizedBox(
          height: 5,
        ));
        items.add(const Padding(
          padding: EdgeInsets.only(left: 35),
          child: Divider(
            height: 1,
          ),
        ));
      }
    }
    return items;
  }
}

class ListTileItem extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  const ListTileItem({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            _buildLeading(),
            Expanded(
              child: Builder(builder: (context) {
                if (subtitle != null) {
                  return Column(
                    children: [
                      title,
                      subtitle!,
                    ],
                  );
                }
                return title;
              }),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }

  Widget _buildLeading() {
    if (leading != null) {
      return Row(
        children: [
          leading!,
          const SizedBox(
            width: 8,
          )
        ],
      );
    }
    return const SizedBox();
  }
}
