import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:use_audio_book/viewmodel/ocr_viewmodel.dart';

class OCRScreen extends StatefulWidget {
  const OCRScreen({super.key});

  @override
  State<OCRScreen> createState() => _OCRScreenState();
}

class _OCRScreenState extends State<OCRScreen> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<OCRViewModel>();
    return Scaffold(
      appBar: AppBar(title: Text("User Audio Book",
      style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent,),

      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
        color: Colors.white,
        child: Column(

          spacing: 10,
          children: [
            ElevatedButton(
              onPressed: () {
                print(vm.isLoading);
                if (vm.isLoading != null && !vm.isLoading!) {
                  print("button is clicked");
                  vm.pickAndExtractText();
                }
              },
              child: Text("Pick an Image"),
            ),

            if (vm.isLoading != null && vm.isLoading!)
              CircularProgressIndicator(),

            if(vm.image != null) Image.file(vm.image!, height: 100,),
            SizedBox(height: 10),

            Expanded(
              child: SingleChildScrollView(
                child: Text(vm.text != null ? vm.text! : ""),
              ),
            ),

            SizedBox(height: 10),


            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: vm.audioState == AudioState.loading
                    ? null
                    : vm.pauseAudio, icon: Icon(Icons.pause)),
                IconButton(onPressed: vm.audioState == AudioState.loading
                    ? null
                    : vm.playAudio, icon: Icon(Icons.play_arrow)),
                IconButton(onPressed: vm.audioState == AudioState.loading
                    ? null
                    : vm.stopAudio, icon: Icon(Icons.stop))

              ],
            )
           ,

            SizedBox(height: 10),

            if (vm.audioState == AudioState.loading)
              Column(
                children: [
                  CircularProgressIndicator(),
                  Text("Generating voice..."),
                ],
              ),

            if (vm.mode != null && vm.mode!.isNotEmpty)
              Text("Mode: ${vm.mode}"),

            if (vm.errorMessage !=  null && vm.errorMessage!.isNotEmpty)
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(vm.errorMessage !=  null ? vm.errorMessage! : ""),
              ),




          ],
        ),
      ),
    );
  }
}
