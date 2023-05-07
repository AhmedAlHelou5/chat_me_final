// import 'dart:io';
//
// import 'package:chat_me_final/services/assets_manager.dart';
// import 'package:chat_me_final/widgets/bottom_sheet_choose_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'bottom_sheet_update_image.dart';
//
// class UserImagePicker extends StatefulWidget {
//   final  Function(File? pickedImage) pickedImageFun;
//   UserImagePicker(this.pickedImageFun);
//
//   @override
//   State<UserImagePicker> createState() => _UserImagePickerState();
// }
//
// class _UserImagePickerState extends State<UserImagePicker> {
//   File? _pickedImage;
//   final ImagePicker _picker = ImagePicker();
//
//   void _pickImage(ImageSource src) async {
//     final pickedImageFile = await _picker.pickImage(source: src,imageQuality: 50,maxWidth: 150);
//     if (pickedImageFile != null) {
//       setState(() {
//         _pickedImage = File(pickedImageFile.path);
//       });
//       widget.pickedImageFun(_pickedImage! as File?);
//     } else {
//       print('No picked image');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         InkWell(
//           onTap: (){
//             showModalBottomSheet(
//               backgroundColor: Colors.transparent,
//               context: context,
//               builder: (builder) => BottomSheetChooseImage(widget.pickedImageFun as File?),
//             );
//           },
//           child: CircleAvatar(
//             radius: 50,
//             backgroundColor: Colors.grey,
//             child: Container(
//               child: Center(
//                 child: _pickedImage == null
//                     ?  Text('no hay imagen')
//                     :  Image.file(_pickedImage! as File),
//               ),
//             ),
//           ),
//         ),
//        const SizedBox(
//           height: 12,
//         ),
//         // Row(
//         //   mainAxisAlignment: MainAxisAlignment.spaceAround,
//         //   children: [
//         //     TextButton.icon(
//         //       onPressed:()=> _pickImage(ImageSource.camera),
//         //       icon: Icon(Icons.photo_camera_outlined),
//         //       label: Text(
//         //         'Add Image\nfrom Camera',
//         //         textAlign: TextAlign.center,
//         //         style: TextStyle(color: Theme.of(context).primaryColor),
//         //       ),
//         //     ),
//         //     TextButton.icon(
//         //       onPressed: () => _pickImage(ImageSource.gallery),
//         //       icon: Icon(Icons.image_outlined),
//         //       label: Text(
//         //         'Add Image\nfrom Gallery',
//         //         textAlign: TextAlign.center,
//         //         style: TextStyle(color: Theme.of(context).primaryColor),
//         //       ),
//         //     )
//         //   ],
//         // )
//       ],
//     );
//   }
// }
// class BottomSheetChooseImage extends StatefulWidget {
//   File? imageProfile;
//
//   BottomSheetChooseImage(this.imageProfile);
//
//   @override
//   State<StatefulWidget> createState() => _BottomSheetChooseImageState();
// }
//
// class _BottomSheetChooseImageState extends State<BottomSheetChooseImage> {
//   Future<void> pickImage(ImageSource src) async {
//     try {
//       final image = await ImagePicker().pickImage(source: src,maxHeight: 675, maxWidth: 900);
//       // if (image != null) {
//       //   setState(() {
//       //     this.imageProfile = PickedFile(image.path);
//       //   });
//       //   print(image);
//       // }
//       final  imageTemp = File(image!.path);
//
//       setState(() => this.widget.imageProfile = imageTemp);
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
//                       pickImage(ImageSource.camera);
//
//                     },
//                     child: const Column(
//                       children: [
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
//                   const SizedBox(
//                     width: 30,
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       Navigator.pop(context);
//                       pickImage(ImageSource.gallery);
//                     },
//                     child: const Column(
//                       children: [
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
