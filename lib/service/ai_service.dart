import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AIService {
  final String apiKey = ""; // add openAi api key here



  Future<String?> cleanText(String rawText) async {
    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/responses"),
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "gpt-4.1-mini",
        "input": "Clean and format this OCR text:\n$rawText",
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data['output'][0]['content'][0]['text'];
    }

    print("Error status cleanText: ${response.statusCode}");
    return throw Exception("Error status: ${response.statusCode}");
  }

  Future<List<int>?> generateSpeech(String text) async {
    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/audio/speech"),
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "gpt-4o-mini-tts",
        "voice": "alloy",
        "input": text,
      }),
    );

    print("status code : ${response.statusCode}");

    if (response.statusCode == 200) {
      return response.bodyBytes; // audio file
    }

    return throw Exception("Error status code: ${response.statusCode}");
  }

  Future<File> saveAudio(List<int> bytes) async {
    final dir = await getTemporaryDirectory();

    // Try .mp3 first (important)
    final file = File('${dir.path}/speech.mp3');

    await file.writeAsBytes(bytes, flush: true);

    return file;
  }
}
