import 'package:flutter/foundation.dart';
import '../../../../core/config/speech_to_text_service.dart';

class VoiceMealLoggingService {
  final SpeechToTextService _speechService;

  bool _isRecording = false;
  String _recognizedText = '';

  VoiceMealLoggingService(this._speechService);

  bool get isRecording => _isRecording;
  bool get isInitialized => _speechService.isInitialized;
  String get recognizedText => _recognizedText;

  Future<VoiceRecordingResult> startListening({
    required Function(String) onTextUpdate,
  }) async {
    if (!_speechService.isInitialized) {
      return VoiceRecordingResult.error('Speech service not initialized');
    }

    if (_isRecording) {
      return VoiceRecordingResult.error('Already recording');
    }

    _recognizedText = '';

    try {
      final success = await _speechService.startListening(
        onResult: (text) {
          _recognizedText = text;
          onTextUpdate(text);
        },
        onError: (error) {
          debugPrint('Voice recording error: $error');
        },
      );

      if (success) {
        _isRecording = true;

        return VoiceRecordingResult.success();
      } else {
        return VoiceRecordingResult.error('Failed to start recording');
      }
    } catch (e) {
      debugPrint('Error starting voice recording: $e');

      return VoiceRecordingResult.error('Unexpected error: $e');
    }
  }

  Future<VoiceRecordingResult> stopListening() async {
    if (!_isRecording) {
      return VoiceRecordingResult.error('Not currently recording');
    }

    try {
      await _speechService.stopListening();
      _isRecording = false;

      if (_recognizedText.isEmpty) {
        return VoiceRecordingResult.error('No speech detected');
      }

      return VoiceRecordingResult.success(data: _recognizedText);
    } catch (e) {
      _isRecording = false;
      debugPrint('Error stopping voice recording: $e');

      return VoiceRecordingResult.error('Failed to stop recording');
    }
  }

  Future<void> cancelListening() async {
    if (_isRecording) {
      await _speechService.cancel();
      _isRecording = false;
      _recognizedText = '';
    }
  }

  void dispose() {
    if (_isRecording) {
      _speechService.stopListening();
      _isRecording = false;
    }
  }
}

class VoiceRecordingResult {
  final bool isSuccess;
  final String? errorMessage;
  final String? data;

  VoiceRecordingResult._({
    required this.isSuccess,
    this.errorMessage,
    this.data,
  });

  factory VoiceRecordingResult.success({String? data}) {
    return VoiceRecordingResult._(isSuccess: true, data: data);
  }

  factory VoiceRecordingResult.error(String message) {
    return VoiceRecordingResult._(isSuccess: false, errorMessage: message);
  }
}
