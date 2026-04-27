import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:use_audio_book/pages/ocr_screen.dart';

import '../service/ai_service.dart';
import '../service/audioservice.dart';
import '../service/imageservice.dart';
import '../service/localtts_service.dart';
import '../service/ocr_service.dart';
import '../viewmodel/ocr_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class App extends StatelessWidget {
  const App({super.key});

  static const colorPrimary = Color(0xff5b4da0);
  Future<void> openUrl() async {
    final Uri url = Uri.parse("https://porlobiit.com/");

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication, // opens in browser
    )) {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //<a href="https://www.flaticon.com/free-icons/open-book" title="open book icons">Open book icons created by Freepik - Flaticon</a>
        leading: Container(
          padding: EdgeInsets.all(10),
          child: Image.asset("assets/images/open-book.png"),
        ),
        title: Text(
          "Make your audio Book",
          style: TextStyle(
            fontFamily: "Plus Jakarta Sans",
            color: Colors.white,
          ),
        ),

        backgroundColor: colorPrimary,
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    final imageService = ImageService();
                    final ocrService = OCRService();
                    final aiService = AIService();
                    final audioService = AudioService();
                    final ttsService = LocalTTSService();

                    Navigator.push(context, MaterialPageRoute(builder: (C)=>  ChangeNotifierProvider(
                      create: (_) => OCRViewModel(
                        imageService: imageService,
                        ocrService: ocrService,
                        aiService: aiService,
                        audioService: audioService,
                        ttsService: ttsService,
                      ),

                      child: OCRScreen(),
                    )));
                  },
                  child: Card(
                    child: Container(
                      height: 150,
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Row(
                        spacing: 20,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            //<a href="https://www.flaticon.com/free-icons/audiobook" title="audiobook icons">Audiobook icons created by chahir - Flaticon</a>
                            child: Image.asset("assets/images/audio-book.png"),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                "Create and Listen to favourite audio book",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                  fontWeight: FontWeight(500),
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 20,
                            //<a href="https://www.flaticon.com/free-icons/pointer" title="pointer icons">Pointer icons created by Alfredo Creates - Flaticon</a>
                            child: Image.asset("assets/images/arrow.png"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //<a href="https://www.flaticon.com/free-icons/conversation" title="conversation icons">Conversation icons created by max.icons - Flaticon</a>
                GestureDetector(
                  onTap: () async {
                        await openUrl();
                  },
                  child: Card(
                    child: Container(
                      height: 230,
                      padding: EdgeInsets.fromLTRB(15, 5, 5,5),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 20,
                        children: [
                          Container(
                            child: CircleAvatar(
                              radius: 40,
                              child: Image.asset(
                                "assets/images/conversation.png",
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              spacing: 10,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  "Gain industrial experience",
                                  //   textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Plus Jakarta Sans",
                                    fontSize: 18,
                                    fontWeight: FontWeight(800),
                                    color: colorPrimary,
                                  ),
                                ),

                                RichText(
                                  text: TextSpan(

                                    children: [
                                      TextSpan(
                                        text:
                                            "Join our IT courses with guaranteed ",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15,
                                          fontWeight: FontWeight(500),
                                          color: colorPrimary,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Internship",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15,
                                          fontWeight: FontWeight(700),
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Click to join courses",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15,
                                          fontWeight: FontWeight(500),
                                          color: colorPrimary,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " @ ",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15,
                                          fontWeight: FontWeight(700),
                                          color: Colors.black54,
                                        ),
                                      ),

                                      TextSpan(
                                        text: "Porlob Institute Of Technology",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 15,
                                          fontWeight: FontWeight(700),
                                          color: Colors.deepPurpleAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
