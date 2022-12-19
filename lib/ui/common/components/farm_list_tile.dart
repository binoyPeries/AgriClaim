import 'package:flutter/material.dart';

class FarmListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Map<String, double>> description;
  final Function? onPressed;
  const FarmListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.add(Text(subtitle));
    children.add(
      Text("Locations Recorded: ${description.length}"),
    );

    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: GestureDetector(
        child: Card(
          elevation: 6,
          child: ListTile(
            title: Text(title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
        onTap: () => onPressed!(),
      ),
    );
  }
}
