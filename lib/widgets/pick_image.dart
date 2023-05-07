import 'dart:io';

import 'package:chat_me_final/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class PickImageWidget extends StatefulWidget {
  File? image;


  PickImageWidget(this.image);

  @override
  State<PickImageWidget> createState() => _PickImageWidgetState();
}

class _PickImageWidgetState extends State<PickImageWidget> {


  Future pickImage(ImageSource src) async {
    try {
      final image = await ImagePicker().pickImage(source: src);

      if(image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.widget.image = imageTemp);
    } on PlatformException catch(e) {
      print('Failed to pick image: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return  Center(
          child: Column(
            children: [
              MaterialButton(
                  color: Colors.blue,
                  child: const Text(
                      "Pick Image from Gallery",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold
                      )
                  ),
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  }
              ),
              MaterialButton(
                  color: Colors.blue,
                  child: const Text(
                      "Pick Image from Camera",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold
                      )
                  ),
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  }
              ),
              SizedBox(height: 20,),
              widget.image != null ? Image.file(widget.image!): Text("No image selected")
            ],
          ),

    );
  }
}