import 'package:flutter/material.dart';
import 'video_form.dart'; // Import the UploadFormPage

class SuccessScreen extends StatefulWidget {
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  int _selectedIndex = 0;
  final List<String> _options = ['More'];

  List<String> _uploadedVideos = []; // List to store uploaded videos
  List<String> _uploadedImages = []; // List to store uploaded images

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('League'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: Center(
        child: _selectedIndex == 2
            ? _buildVideoContent()
            : _selectedIndex == 1
                ? _buildImageContent()
                : Text('Content Area'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'More',
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 40, left: 20, bottom: 20),
                color: Colors.blue,
                child: Text(
                  'Dashboard',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: _options.map((option) {
                    return Container(
                      color: Colors.grey[200],
                      child: ListTile(
                        title: Text(
                          option,
                          style: TextStyle(fontSize: 18),
                        ),
                        onTap: () {
                          _handleOptionTap(context, option);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Uploaded Videos',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20.0),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _uploadedVideos.length, // Use the uploaded videos list
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(_uploadedVideos[index]), // Display uploaded video
            );
          },
        ),
      ],
    );
  }

  Widget _buildImageContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Uploaded Images',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20.0),
        // Display uploaded images
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: _uploadedImages.length, // Use the uploaded images list
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
                _uploadedImages[index]); // Display uploaded image
          },
        ),
      ],
    );
  }

  void _handleOptionTap(BuildContext context, String option) {
    switch (option) {
      case 'More':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UploadFormPage(
              // Implementation for handling uploaded videos
              onVideoUploaded: (videoUrl) {
                // Here you can save the video URL to a list, database, or perform any other action
                print('Video uploaded: $videoUrl');
              },
              // Implementation for handling uploaded images
              onImagesUploaded: (imageUrls) {
                // Here you can save the image URLs to a list, database, or perform any other action
                print('Images uploaded: $imageUrls');
              },
            ),
          ),
        );
        break;
    }
  }
}
