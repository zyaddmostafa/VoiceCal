import 'package:flutter/material.dart';

class SpeedIconsRow extends StatelessWidget {
  const SpeedIconsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.slow_motion_video, size: 24, color: Colors.black),
        Icon(Icons.pets, size: 24, color: Colors.black),
        Icon(Icons.directions_run, size: 24, color: Colors.black),
      ],
    );
  }
}
