import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:use_audio_book/pages/app.dart';
import 'package:use_audio_book/service/ai_service.dart';
import 'package:use_audio_book/service/audioservice.dart';
import 'package:use_audio_book/service/imageservice.dart';
import 'package:use_audio_book/service/localtts_service.dart';
import 'package:use_audio_book/service/ocr_service.dart';
import 'package:use_audio_book/viewmodel/ocr_viewmodel.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  final imageService = ImageService();
  final ocrService = OCRService();
  final aiService = AIService();
  final audioService = AudioService();
  final ttsService = LocalTTSService();
  runApp(
    MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => OCRViewModel(
          imageService: imageService,
          ocrService: ocrService,
          aiService: aiService,
          audioService: audioService,
          ttsService: ttsService,
        ),

        child: OCRScreen(),
      ),
    ),
  );
}
