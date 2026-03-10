import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'services/voice_service.dart';

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  final VoiceService _voiceService = VoiceService();
  String _recognizedText = 'Tap the mic and start speaking...';
  String _status = 'Ready';
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeSpeech();
  }

  Future<void> _initializeSpeech() async {
    setState(() => _status = 'Initializing...');
    final available = await _voiceService.initialize();
    if (!mounted) return;
    setState(() {
      _isInitialized = available;
      _status = available ? 'Speech recognition is ready.' : 'Unavailable.';
    });
  }

  // Calls startListening()
  Future<void> _startListening() async {
    if (!_isInitialized) {
      setState(() {
        _status = 'Please wait until speech recognition is ready.';
      });
      return;
    }

    setState(() {
      _status = 'Listening...';
    });

    await _voiceService.startListening(
      onResult: _onSpeechResult,
      onError: _onSpeechError,
    );

    if (!mounted) {
      return;
    }

    if (_voiceService.isListening) {
      setState(() {
        _status = 'Listening...';
      });
    }
  }

  // Calls stopListening()
  Future<void> _stopListening() async {
    await _voiceService.stopListening();

    if (!mounted) {
      return;
    }

    setState(() {
      _status = 'Stopped listening.';
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (!mounted) {
      return;
    }

    setState(() {
      _recognizedText = result.recognizedWords.isEmpty
          ? 'I could not catch that. Please try again.'
          : result.recognizedWords;

      if (result.finalResult) {
        _status = 'Final result received.';
      }
    });
  }

  void _onSpeechError(String message) {
    if (!mounted) {
      return;
    }

    setState(() {
      _status = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isListening = _voiceService.isListening;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Workshop'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _recognizedText,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Status: $_status',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: isListening ? null : _startListening,
              icon: const Icon(Icons.mic),
              label: const Text('Start Listening'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: isListening ? _stopListening : null,
              icon: const Icon(Icons.stop_circle_outlined),
              label: const Text('Stop Listening'),
            ),
          ],
        ),
      ),
    );
  }
}