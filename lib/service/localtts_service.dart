import 'package:flutter_tts/flutter_tts.dart';

class LocalTTSService {
  final FlutterTts _tts = FlutterTts();

  Future<void> speak(String text) async {
    await _tts.setLanguage("en-US");
    await _tts.setSpeechRate(0.5);
    await _tts.setPitch(1.0);

    await _tts.speak(text);

  }
  Future<void> pause() async => _tts.pause();
  //Future<void> resume() async => _tts

  Future<void> stop() async => _tts.stop();
}