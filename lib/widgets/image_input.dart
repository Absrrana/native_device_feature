import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path; // to get the file name
import 'package:path_provider/path_provider.dart'
    as syspaths; // to get the path

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  // we are File property because we are going to store the image
  File? _storedImage;

  // image picker future function to take the image
  Future<void> _takePicture() async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    // if the image is null we are going to return nothing
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path); // we are going to store the image
    });
    // we are going to get the app directory
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    // to copy the image to the app directory
    final fileName = path.basename(imageFile.path);
    // we are going to store the image
    final savedImage = await _storedImage!.copy('${appDir.path}/$fileName.png');

    // we are going to call the onSelectImage function to save the image
    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    // we are going to return a Row widget
    return Row(
      children: [
        // container to show the image
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.fill,
                  width: double.infinity,
                )
              : const Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
        ),
        const SizedBox(width: 10),
        // button to take the picture
        Expanded(
          child: TextButton.icon(
            icon: const Icon(Icons.camera),
            label: const Text('Take Picture'),
            onPressed: _takePicture,
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              // backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ],
    );
  }
}
