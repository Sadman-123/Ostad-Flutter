import 'package:assignment3/screen/desktop_view.dart';
import 'package:assignment3/screen/mobile_view.dart';
import 'package:assignment3/screen/tablet_view.dart';
import 'package:assignment3/widgets/responsive_helper.dart';
import 'package:flutter/material.dart';
class Home extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Responsive_helper(
        mobile: Mobile_View(),
        tablet: Tablet_View(),
        desktop: Desktop_View()
    );
  }
}