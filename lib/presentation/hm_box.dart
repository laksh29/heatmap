// I have wrapped the MapContainer over MapContainer because, the boxColor depends on the opacity, and if we have a color bg, the color of the box will not be as expected
import 'package:flutter/material.dart';

class HmBox extends StatelessWidget {
  const HmBox({
    super.key,
    this.boxColor,
    this.showBorder = false,
    this.boxDimension,
    this.onTap,
  });
  final Color? boxColor;
  final bool showBorder;
  final double? boxDimension;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: MapContainer(
        boxDimension: boxDimension,
        boxColor: Colors.transparent,
        showBorder: showBorder,
        child: MapContainer(
          boxDimension: boxDimension,
          boxColor: boxColor,
        ),
      ),
    );
  }
}

// basic container design that will be used in the HM and in the color guide
class MapContainer extends StatelessWidget {
  const MapContainer({
    super.key,
    required this.boxColor,
    this.child,
    this.showBorder = false,
    this.boxDimension,
  });

  final Color? boxColor;
  final Widget? child;
  final bool showBorder;
  final double? boxDimension;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: boxDimension ?? 20.0,
      height: boxDimension ?? 20.0,
      decoration: BoxDecoration(
        color: boxColor ?? Colors.white,
        borderRadius: BorderRadius.circular(2.0),
        border: showBorder
            ? Border.all(color: Colors.black.withOpacity(0.1))
            : null,
      ),
      child: child,
    );
  }
}
