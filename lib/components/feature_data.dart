import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeatureData extends StatelessWidget {
  const FeatureData(
      {super.key,
      required this.icon,
      required this.propertyName,
      required this.percentage});
  final IconData icon;
  final String propertyName;
  final String percentage;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        Text(
          propertyName,
          style: TextStyle(color: Colors.white),
        ),
        Text(
          percentage,
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
