import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:shareapp/image_picker.dart';
import 'package:shareapp/text.dart';
import 'package:shareapp/video.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;
  late PageController _pageController;

  TextEditingController textdata = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      body: SizedBox.expand(
        
        
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
           children: [
            // Container(color: Colors.orange),
            // Container(color: Colors.red),
            // Container(color: Colors.purple),

          const  TextImage(),
            ShareImagePage(),
            VideoPickerAndSharePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
         backgroundColor: Colors.lightBlue[50],
        
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        items: <BottomNavyBarItem>[
        
          
          BottomNavyBarItem(
            
            icon: const Icon(Icons.text_fields),
            title: const Text('Menu'),
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.image),
            title: const Text('Gallery'),
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.video_call_outlined),
            title: const Text('Video'),
          ),
        ],
      ),
    );
  }
}
