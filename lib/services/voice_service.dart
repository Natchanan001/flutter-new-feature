import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceService {
  final SpeechToText _speechToText = SpeechToText();

  bool get isAvailable => _speechToText.isAvailable;
  bool get isListening => _speechToText.isListening;

  // 1) initialize() -> open speech recognition engine
  Future<bool> initialize() async {
    return _speechToText.initialize(
      debugLogging: false,
    );
  }

  // 2) startListening() -> convert voice to text
  Future<void> startListening({
    required void Function(SpeechRecognitionResult result) onResult,
    void Function(String errorMessage)? onError,
  }) async {
    if (!isAvailable) {
      final initialized = await initialize();
      if (!initialized) {
        onError?.call('Speech recognition is not available on this device.');
        return;
      }
    }

    await _speechToText.listen(
      onResult: onResult,
      listenMode: ListenMode.confirmation,
      partialResults: true,
      cancelOnError: true,
      localeId: 'en_US',
    );
  }

  // 3) stopListening() -> stop recording/listening
  Future<void> stopListening() async {
    if (!isListening) {
      return;
    }
    await _speechToText.stop();
  }
}
