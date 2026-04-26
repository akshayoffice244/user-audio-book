import 'dart:io';

import 'dart:typed_data'; // 👈 IMPORTANT
import 'package:audioplayers/audioplayers.dart';


class AudioService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playFromBytes(List<int> bytes) async {
    final uint8List = Uint8List.fromList(bytes); // ✅ convert here
    await _player.play(BytesSource(uint8List));
  }

  Future<void> pause() async => _player.pause();

  Future<void> stop() async => _player.stop();
  Future<void> resume() async => _player.resume();




  Future<void> playFromFile(File file) async {
    await _player.stop(); // reset
    await _player.play(DeviceFileSource(file.path));
  }

}