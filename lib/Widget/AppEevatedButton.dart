import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    Key? key,
    required this.child,
    required this.onTap, this.Color,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onTap;
  final Color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Color,
              padding: const EdgeInsets.all(6)),
          onPressed: onTap,

          child: child),
    );
  }
}