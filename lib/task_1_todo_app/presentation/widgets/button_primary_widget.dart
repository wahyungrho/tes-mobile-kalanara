import 'package:flutter/material.dart';

class ButtonPrimaryWidget extends StatelessWidget {
  final double? width;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Widget? child;
  final void Function()? onPressed;
  const ButtonPrimaryWidget({
    super.key,
    this.width,
    this.backgroundColor,
    this.foregroundColor,
    this.child,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          if (onPressed != null) {
            onPressed!();
          }
        },
        child: child ?? const Text('Button'),
      ),
    );
  }
}
