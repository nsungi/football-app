import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  final List<String> uploadedVideos;
  final List<String> uploadedImages;

  // Mark the parameters as required
  const SuccessScreen({
    required this.uploadedVideos,
    required this.uploadedImages,
  });

  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  int _selectedIndex = 0;

  // Options for the hamburger menu
  final List<String> _options = ['PDF', 'Image', 'Video', 'More'];

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
          // Handle bottom navigation bar item tap
          switch (index) {
            case 0:
              // Home icon tapped
              break;
            case 1:
              // Explore icon tapped
              break;
            case 2:
              // Notifications icon tapped
              break;
            case 3:
              // Message icon tapped
              break;
            case 4:
              // More icon tapped
              break;
          }
        },
        selectedItemColor: Colors.blue, // Set the color of the selected item
        unselectedItemColor: Colors.grey, // Set the color of unselected items
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
          width: MediaQuery.of(context).size.width *
              0.75, // Adjust width as needed
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
                      color: Colors.grey[200], // Set background color
                      child: ListTile(
                        title: Text(
                          option,
                          style: TextStyle(fontSize: 18),
                        ),
                        onTap: () {
                          // Handle option tap
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
        // Display uploaded videos
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.uploadedVideos.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(widget.uploadedVideos[index]),
              // You can customize how you want to display the uploaded videos here
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
          itemCount: widget.uploadedImages.length,
          itemBuilder: (BuildContext context, int index) {
            return Image.network(widget.uploadedImages[index]);
            // You can customize how you want to display the uploaded images here
          },
        ),
      ],
    );
  }

  void _handleOptionTap(BuildContext context, String option) {
    // Implement functionality for each option
    switch (option) {
      case 'PDF':
        // Navigate to PDF page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PdfPage()),
        );
        break;
      case 'Image':
        // Navigate to Image page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ImagePage()),
        );
        break;
      case 'Video':
        // Navigate to Video page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VideoPage()),
        );
        break;
      case 'More':
        // Navigate to More page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MorePage()),
        );
        break;
    }
  }
}

// Example page widgets (replace these with your actual page widgets)
class PdfPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Page'),
      ),
      body: Container(
        color: Colors.blue[200], // Setting background color
        height: MediaQuery.of(context).size.height * 0.5,
        child: Center(
          child: Text(
            'PDF Page Content',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class ImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Page'),
      ),
      body: Container(
        color: Colors.orange[200], // Setting background color
        height: MediaQuery.of(context).size.height * 0.5,
        child: Center(
          child: Text(
            'Image Page Content',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class VideoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Page'),
      ),
      body: Container(
        color: Colors.green[200], // Setting background color
        height: MediaQuery.of(context).size.height * 0.5,
        child: Center(
          child: Text(
            'Video Page Content',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More Page'),
      ),
      body: Container(
        color: Colors.purple[200], // Setting background color
        height: MediaQuery.of(context).size.height * 0.5,
        child: Center(
          child: Text(
            'More Page Content',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
