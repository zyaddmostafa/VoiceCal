import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeightRuler extends StatefulWidget {
  final double min;
  final double max;
  final double initial;
  final ValueChanged<double> onChanged;

  const WeightRuler({
    super.key,
    required this.min,
    required this.max,
    required this.initial,
    required this.onChanged,
  });

  @override
  State<WeightRuler> createState() => _WeightRulerState();
}

class _WeightRulerState extends State<WeightRuler> {
  late final ScrollController _controller;

  static const int ticksPerUnit = 10; // one decimal precision
  static const double tickSpacing = 8.0; // px between tiny ticks

  @override
  void initState() {
    super.initState();
    _controller = ScrollController(
      initialScrollOffset: _valueToOffset(widget.initial),
    );
    _controller.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleScroll);
    _controller.dispose();
    super.dispose();
  }

  double _valueFromOffset(double offset) {
    final totalTicksPerUnit = ticksPerUnit;
    final unitsFromMin = offset / tickSpacing / totalTicksPerUnit;
    final value = widget.min + unitsFromMin;
    return value.clamp(widget.min, widget.max);
  }

  double _valueToOffset(double value) {
    final clamped = value.clamp(widget.min, widget.max);
    final units = clamped - widget.min;
    return units * ticksPerUnit * tickSpacing;
  }

  void _handleScroll() {
    widget.onChanged(_valueFromOffset(_controller.offset));
  }

  @override
  Widget build(BuildContext context) {
    final totalUnits = (widget.max - widget.min);
    final totalTicks = (totalUnits * ticksPerUnit).toInt();
    final indicatorHeight = 56.h;

    return SizedBox(
      height: 80.h,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Scrollable ruler
              ListView.builder(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: totalTicks + 1,
                itemBuilder: (context, index) {
                  final isMajor = index % ticksPerUnit == 0;
                  final isMedium = index % 5 == 0 && !isMajor;
                  final height = isMajor
                      ? 28.h
                      : isMedium
                      ? 20.h
                      : 12.h;
                  return Container(
                    width: tickSpacing,
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 2,
                      height: height,
                      color: const Color(0xFF2C2C2E),
                    ),
                  );
                },
              ),

              // Shaded area from center to left edge
              Positioned(
                left: 0,
                right: constraints.maxWidth / 2,
                top: 0,
                bottom: 0,
                child: Container(
                  color: const Color(0xFFE5E5EA).withValues(alpha: 0.5),
                ),
              ),

              // Center indicator
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 2.5,
                  height: indicatorHeight,
                  color: Colors.black,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
