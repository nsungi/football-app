import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UploadFormPage extends StatefulWidget {
  final Function(String)
      onVideoUploaded; // Callback function for uploaded videos
  final Function(List<String>)
      onImagesUploaded; // Callback function for uploaded images

  UploadFormPage({
    required this.onVideoUploaded,
    required this.onImagesUploaded,
  });

  @override
  _UploadFormPageState createState() => _UploadFormPageState();
}

class _UploadFormPageState extends State<UploadFormPage> {
  final TextEditingController _videoTitleController = TextEditingController();
  final TextEditingController _videoDescriptionController =
      TextEditingController();
  final TextEditingController _imageTitleController = TextEditingController();
  final TextEditingController _imageDescriptionController =
      TextEditingController();
  File? _videoFile;
  List<File> _imageFiles = [];

  String _selectedVideoFileName = '';
  String _selectedImageFileNames = '';

  Future<void> _selectVideo(BuildContext context) async {
    final pickedFile =
        await ImagePicker().getVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _videoFile = File(pickedFile.path);
        _selectedVideoFileName = _videoFile!.path.split('/').last;
      });
    }
  }

  Future<void> _selectImages(BuildContext context) async {
    final pickedFiles = await ImagePicker().pickMultiImage();
    setState(() {
      _imageFiles =
          pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
      _selectedImageFileNames =
          _imageFiles.map((file) => file.path.split('/').last).join(', ');
    });
  }

  Future<void> _uploadVideo(BuildContext context) async {
    if (_videoFile == null) {
      // Show error message
      return;
    }

    var apiUrl = Uri.parse('http://192.168.1.115:8000/api/main/videos/upload/');
    var request = http.MultipartRequest('POST', apiUrl);
    request.fields['title'] = _videoTitleController.text;
    request.fields['description'] = _videoDescriptionController.text;
    request.files
        .add(await http.MultipartFile.fromPath('file', _videoFile!.path));

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    var jsonResponse = json.decode(responseData);

    if (response.statusCode == 201) {
      // Video uploaded successfully, show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Video uploaded successfully!')),
      );

      // Example: Accessing a specific key from the response
      var videoUrl = jsonResponse['video_url'];
      print('Uploaded video URL: $videoUrl');

      // Call the callback function with the video URL
      widget.onVideoUploaded(videoUrl);
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload video')),
      );
    }
  }

  Future<void> _uploadImages(BuildContext context) async {
    if (_imageFiles.isEmpty) {
      // Show error message
      return;
    }

    var apiUrl = Uri.parse('http://192.168.1.115:8000/api/main/images/upload/');
    List<String> uploadedImageUrls = [];
    for (var imageFile in _imageFiles) {
      var request = http.MultipartRequest('POST', apiUrl);
      request.fields['title'] = _imageTitleController.text;
      request.fields['description'] = _imageDescriptionController.text;
      request.files
          .add(await http.MultipartFile.fromPath('file', imageFile.path));

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseData);

      if (response.statusCode == 201) {
        // Image uploaded successfully, show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image uploaded successfully!')),
        );

        // Example: Accessing a specific key from the response
        var imageUrl = jsonResponse['image_url'];
        print('Uploaded image URL: $imageUrl');
        uploadedImageUrls.add(imageUrl);
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image')),
        );
      }
    }
    // Call the callback function with the list of image URLs
    widget.onImagesUploaded(uploadedImageUrls);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 10.0),
            Text(
              'Upload Video',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _videoTitleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _videoDescriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton.icon(
              onPressed: () => _selectVideo(context),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                backgroundColor: _videoFile == null ? Colors.blue : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              icon: Icon(Icons.video_library),
              label: Text(
                _videoFile == null
                    ? 'Select Video'
                    : 'Selected Video: $_selectedVideoFileName',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _uploadVideo(context),
              child: Text('Upload Video'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Upload Images',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _imageTitleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _imageDescriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton.icon(
              onPressed: () => _selectImages(context),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                backgroundColor:
                    _imageFiles.isEmpty ? Colors.blue : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              icon: Icon(Icons.image),
              label: Text(
                _imageFiles.isEmpty
                    ? 'Select Images'
                    : 'Selected Images: $_selectedImageFileNames',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => _uploadImages(context),
              child: Text('Upload Images'),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
