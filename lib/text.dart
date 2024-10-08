import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class TextImage extends StatefulWidget {
  const TextImage({super.key});

  @override
  State<TextImage> createState() => _TextImageState();
}

class _TextImageState extends State<TextImage> {
  final TextEditingController textdata = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const  Text(
          'Welcome to Text Post',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const  SizedBox(
              height: 100,
            ),
            TextField(
              controller: textdata,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                suffix: const Icon(Icons.text_snippet),
                border: const OutlineInputBorder(),
                labelText: 'Enter Message',
                
                
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.0)),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.lightBlue),
              child:  const Text('Share Text Message'),
              onPressed: () async {
               
                if(textdata.text.isNotEmpty){
                  await Share.share('${textdata.text}');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
