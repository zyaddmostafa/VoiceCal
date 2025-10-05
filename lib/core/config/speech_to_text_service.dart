import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextService {
  final SpeechToText _speechToText = SpeechToText();
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  bool get isListening => _speechToText.isListening;

  bool get isAvailable => _speechToText.isAvailable;

  Future<bool> speechToTextInit() async {
    try {
      _isInitialized = await _speechToText.initialize(
        onError: (error) {
          debugPrint('Speech recognition error during init: ${error.errorMsg}');
        },
        onStatus: (status) {
          debugPrint('Speech recognition status: $status');
        },
      );

      if (_isInitialized) {
        debugPrint('Speech-to-text initialized successfully');
      } else {
        debugPrint('Speech-to-text initialization failed');
      }

      return _isInitialized;
    } catch (e) {
      debugPrint('Error initializing speech-to-text: $e');
      _isInitialized = false;

      return false;
    }
  }

  Future<bool> startListening({
    required Function(String) onResult,
    Function(String)? onError,
  }) async {
    if (!_isInitialized) {
      debugPrint(
        'Speech-to-text not initialized. Call speechToTextInit() first.',
      );
      onError?.call('Service not initialized');

      return false;
    }

    if (_speechToText.isListening) {
      debugPrint('Already listening');

      return true;
    }

    try {
      await _speechToText.listen(
        onResult: (result) {
          if (result.recognizedWords.isNotEmpty) {
            onResult(result.recognizedWords);
          }
        },
        listenFor: const Duration(seconds: 60),
        // pauseFor: const Duration(seconds: 3),
        localeId: 'en_US',
        onSoundLevelChange: (level) {
          debugPrint('Sound level: $level');
        },
        listenOptions: SpeechListenOptions(
          partialResults: true,
          cancelOnError: true,
          listenMode: ListenMode.confirmation,
        ),
      );

      return true;
    } catch (e) {
      debugPrint('Error starting speech recognition: $e');
      onError?.call('Failed to start listening: $e');

      return false;
    }
  }

  Future<void> stopListening() async {
    if (_speechToText.isListening) {
      await _speechToText.stop();
      debugPrint('Stopped listening');
    }
  }

  Future<void> cancel() async {
    if (_speechToText.isListening) {
      await _speechToText.cancel();
      debugPrint('Cancelled listening');
    }
  }

  void dispose() {
    if (_speechToText.isListening) {
      _speechToText.stop();
    }
    _isInitialized = false;
  }
}
