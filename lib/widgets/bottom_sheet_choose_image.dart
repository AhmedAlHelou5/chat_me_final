// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
//
//
//
// class BottomSheetChooseImage extends StatefulWidget {
//
//
//
//   @override
//   State<StatefulWidget> createState() => _BottomSheetChooseImageState();
// }
//
// class _BottomSheetChooseImageState extends State<BottomSheetChooseImage> {
//   PickedFile? imageProfile;
//   Future<void> pickImage(ImageSource src) async {
//     try {
//       final image = await ImagePicker().pickImage(source: src,maxHeight: 675, maxWidth: 900);
//       if (image != null) {
//         setState(() {
//           this.imageProfile = PickedFile(image.path);
//         });
//         print(image);
//       }
//       // final  imageTemp = PickedFile (image.path);
//       //
//       // setState(() => this.image = imageTemp);
//     } on PlatformException catch(e) {
//       print('Failed to pick image: $e');
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.20,
//       width: MediaQuery.of(context).size.width * 0.50,
//       child: Card(
//         margin: const EdgeInsets.all(18.0),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   InkWell(
//                     onTap: () async {
//                       Navigator.pop(context);
//
//                       pickImage(ImageSource.camera);
//
//
//                     },
//                     child: Column(
//                       children: const [
//                         CircleAvatar(
//                           radius: 30,
//                           backgroundColor: Colors.pink,
//                           child: Icon(
//                             Icons.camera_alt,
//                             // semanticLabel: "Help",
//                             size: 29,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Text(
//                           'Camera',
//                           style: TextStyle(
//                             fontSize: 12,
//                             // fontWeight: FontWeight.w100,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                  const SizedBox(
//                     width: 30,
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       Navigator.pop(context);
//                       pickImage(ImageSource.gallery);
//                     },
//                     child: Column(
//                       children: const [
//                         CircleAvatar(
//                           radius: 30,
//                           backgroundColor: Colors.purple,
//                           child: Icon(
//                             Icons.insert_photo,
//                             // semanticLabel: "Help",
//                             size: 29,
//                             color: Colors.white,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Text(
//                           'Gallery',
//                           style: TextStyle(
//                             fontSize: 12,
//                             // fontWeight: FontWeight.w100,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
