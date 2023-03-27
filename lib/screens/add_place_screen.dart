import 'package:flutter/material.dart';
import '../widgets/image_input.dart';
import 'dart:io';
import '../providers/great_palces.dart';
import 'package:provider/provider.dart';
import '../widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);
  static const routeName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;

  //we are creating a method to get the image from the image input widget
  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  //we are creating a method to save the place
  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new place'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //input form
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    const SizedBox(height: 10),
                    Container(),
                    ImageInput(_selectImage),
                    const SizedBox(height: 10),
                    LocationInput(),
                  ],
                ),
              ),
            ),
          ),
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: Theme.of(context).colorScheme.secondary,
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0,
            ),
            icon: const Icon(Icons.add),
            label: const Text('Add Place'),
            onPressed: _savePlace,
          )
        ],
      ),
    );
  }
}
