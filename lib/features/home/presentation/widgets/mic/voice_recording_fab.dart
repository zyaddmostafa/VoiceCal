import 'package:flutter/material.dart';

import '../../../../../core/helpers/spacing.dart';
import 'mic_button_widget.dart';
import 'recording_timer_widget.dart';

class VoiceRecordingFab extends StatelessWidget {
  final bool isRecording;
  final VoidCallback onPressed;

  const VoiceRecordingFab({
    super.key,
    required this.isRecording,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RecordingTimerWidget(isRecording: isRecording, maxDuration: 30),
        if (isRecording) verticalSpace(16),
        MicButtonWidget(isRecording: isRecording, onPressed: onPressed),
      ],
    );
  }
}
