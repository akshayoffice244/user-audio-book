import "dart:io";

import 'package:flutter/material.dart';

enum AudioState { idle, loading, success, error }

class OCRViewModel extends ChangeNotifier {
  final imageService;
  final ocrService;
  final aiService;
  final audioService;
  final ttsService;

  OCRViewModel({
    required this.imageService,
    required this.ocrService,
    required this.aiService,
    required this.audioService,
    required this.ttsService,
  });

  File? image;
  String? text;
  AudioState? audioState = AudioState.idle;
  String? errorMessage;
  String? mode = "";
  bool? isLoading =false;
  bool? isPlaying = false;

  Future<void> pickAndExtractText() async {
    isLoading = true;
    notifyListeners();

    try {
      final picked = await imageService.pickImage();
      if (picked == null) {
        isLoading = false;
        notifyListeners();
        return;
      }
      image = picked;

      text = await ocrService.extractText(image);
    } catch (e) {
      errorMessage = "Failed to extract text";
    }

    isLoading = false;
    notifyListeners();
  }


  Future<void> playAudio() async{
    if(text == null || text!.isEmpty) return;

    audioState = AudioState.loading;
    errorMessage =  "";
    notifyListeners();
    try{
      final bytes = await aiService.generateAudio(text);
      if(bytes != null && bytes.length > 10000){
        final file = await aiService.saveAudio(bytes);
        await  audioService.playFile(file);
        mode = "AI Voice";
        audioState = AudioState.success;
        isPlaying = true;
      }else{
        throw Exception("Invalid");
      }
      
    }catch(e){
      await ttsService.speak(text);
      mode  = "Offline Voice";
      isPlaying = true;
      audioState = AudioState.error;
      errorMessage = _mapError(e);
    }
    notifyListeners();
  }
  Future<void> pauseAudio() async{
    if(isPlaying != null && isPlaying!){
      if(mode == "AI Voice"){
          await audioService.pause();
      }else{
        await ttsService.pause();
      }

    }

  }
  Future<void> stopAudio() async{

    if(isPlaying != null && isPlaying!){
      if(mode == "AI Voice"){
        await audioService.stop();
      }else{
        await ttsService.stop();
      }

    }
  }
  
  String _mapError(dynamic e){
    final err = e.toString();

    if (err.contains("429")) {
      return "Server busy. Using offline voice.";
    } else if (err.contains("401")) {
      return "Authentication issue.";
    } else if (err.contains("SocketException")) {
      return "No internet connection.";
    } else {
      return "Something went wrong.";
    }
  }
}
