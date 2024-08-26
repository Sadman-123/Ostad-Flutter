import 'package:flutter/material.dart';
class Responsive_helper extends StatelessWidget{
  Responsive_helper({
    required this.mobile,
    required this.desktop,
    this.tablet
});
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth<640)
          {
            return mobile;
          }
        else if(constraints.maxWidth>=640 && constraints.maxWidth<1008)
          {
            return tablet??mobile;
          }
        else{
          return desktop;
        }
      },
    );
  }
}