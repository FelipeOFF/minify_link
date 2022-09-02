import 'package:flutter/material.dart';

class CustomSectionSliver extends StatelessWidget {
  final String text;

  const CustomSectionSliver({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 30.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23.0),
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
