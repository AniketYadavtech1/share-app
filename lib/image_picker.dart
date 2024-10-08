import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

class ShareImagePage extends StatefulWidget {
  @override
  _ShareImagePageState createState() => _ShareImagePageState();
}

class _ShareImagePageState extends State<ShareImagePage> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  Future<void> _shareImage() async {
    if (_imageFile != null) {
      await Share.shareXFiles([XFile(_imageFile!.path)]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Share Image Example',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_imageFile != null)
              Image.file(
                _imageFile!,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.lightBlue,
                foregroundColor: Colors.white,
              ),
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
            const SizedBox(height: 20),
            if (_imageFile != null)
              ElevatedButton(
               style:ElevatedButton.styleFrom(
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                backgroundColor: Colors.lightBlue,
                foregroundColor: Colors.white,

               ),
                onPressed: _shareImage,
                child: const Text('Share Image'),
              ),
          ],
        ),
      ),
    );
  }
}
