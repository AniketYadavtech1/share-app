import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:share_plus/share_plus.dart';

class VideoPickerAndSharePage extends StatefulWidget {
  @override
  _VideoPickerAndSharePageState createState() =>
      _VideoPickerAndSharePageState();
}

class _VideoPickerAndSharePageState extends State<VideoPickerAndSharePage> {
  File? _videoFile;
  VideoPlayerController? _videoController;
  final TextEditingController _urlController = TextEditingController();
  bool _isSharingUrl = false;

  Future<void> _pickVideo() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
        _videoController = VideoPlayerController.file(_videoFile!)
          ..initialize().then((_) {
            setState(() {});
            _videoController!.play();
          }).catchError((error) {
            print('Error initializing video player: $error');
          });
      });
    }
  }

  Future<void> _shareVideo() async {
    if (_isSharingUrl) {
      String videoUrl = _urlController.text.trim();
      if (videoUrl.isNotEmpty) {
        try {
          await Share.share(videoUrl);
        } catch (e) {
          print('Error sharing video URL: $e');
        }
      } else {
        print('No video URL to share');
      }
    } else if (_videoFile != null) {
      try {
        await Share.shareXFiles([XFile(_videoFile!.path)]);
      } catch (e) {
        print('Error sharing video: $e');
      }
    } else {
      print('No video file or URL to share');
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pick, Show, and Share Video'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (_videoFile != null)
                  _videoController != null &&
                          _videoController!.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _videoController!.value.aspectRatio,
                          child: VideoPlayer(_videoController!),
                        )
                      : CircularProgressIndicator()
                else
                  const Text('No video selected'),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      )),
                  onPressed: _pickVideo,
                  child: const Text('Pick Video'),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _urlController,
                  decoration: InputDecoration(
                    labelText: 'Enter video URL',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  keyboardType: TextInputType.url,
                  onChanged: (text) {
                    setState(() {
                      _isSharingUrl = text.trim().isNotEmpty;
                    });
                  },
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    backgroundColor: Colors.lightBlue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _shareVideo,
                  child: const Text('Share Video or URL'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
