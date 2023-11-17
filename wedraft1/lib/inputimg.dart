import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InputImg extends StatefulWidget {
  final String? initialImagePath;

  InputImg({Key? key, this.initialImagePath}) : super(key: key);

  @override
  _InputImgState createState() => _InputImgState();
}

class _InputImgState extends State<InputImg> {
  final ImagePicker _picker = ImagePicker();
  late String? imagePath;

  @override
  void initState() {
    super.initState();
    imagePath = widget.initialImagePath;
  }

  Future<String?> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return pickedFile.path;
    } else {
      return null;
    }
  }

  void _saveChanges() {
    Navigator.pop(context, imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Another Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
              child: ClipOval(
                child: imagePath != null
                    ? Image.file(
                  File(imagePath!),
                  fit: BoxFit.cover,
                )
                    : Container(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final imagePath = await _getImage();
                setState(() {
                  this.imagePath = imagePath;
                });
              },
              child: Text('Select Image'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _saveChanges(),
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
