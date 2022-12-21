import 'package:agriclaim/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FarmListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Map<String, double>> locations;
  final Function? onPressed;
  const FarmListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.locations,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.add(SizedBox(
      height: 2.2.h,
    ));
    children.add(const Text(
      "Farm Name:",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ));
    children.add(Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black54,
      ),
    ));
    children.add(SizedBox(
      height: 0.7.h,
    ));
    children.add(const Text(
      "Farm Address:",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ));
    children.add(Text(
      subtitle,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black54,
      ),
    ));
    children.add(SizedBox(
      height: 0.7.h,
    ));
    children.add(
      RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            const TextSpan(
              text: "Locations Recorded: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(text: "${locations.length}"),
          ],
        ),
      ),
    );
    children.add(
      Padding(
        padding: EdgeInsets.only(top: 1.h, bottom: 1.2.h),
        child: const Center(
          child: Text(
            "View More",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AgriClaimColors.primaryColor,
            ),
          ),
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: PhysicalModel(
            elevation: 5,
            shadowColor: Colors.black,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            child: ListTile(
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ),
        ),
        onTap: () => onPressed!(),
      ),
    );
  }
}
