import 'package:flutter/material.dart';

class EditTextLogin extends StatelessWidget {

    String? label;
    String? keyvalue;
    String? hint;
    dynamic textSaved;
    Icon? icon;
    bool? show;
    FormFieldValidator<dynamic>? validator;



    EditTextLogin({required this.label,required this.UserNameController,required this.hint,required this.textSaved,required this.icon,this.validator,required this.show,required this.keyvalue});
    TextEditingController? UserNameController;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20,top: 30),
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: show!,
          key: ValueKey(keyvalue),
          decoration:  InputDecoration(
          hintText: hint,
          labelText: label,
          labelStyle:const TextStyle(color: Colors.white),
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon:icon,
          focusedBorder:OutlineInputBorder(
            borderSide:
            const BorderSide(width: 3, color: Colors.white), //<-- SEE HERE
            borderRadius: BorderRadius.circular(50.0),
          ),

          disabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(width: 3, color: Colors.grey), //<-- SEE HERE
            borderRadius: BorderRadius.circular(50.0),
          ),
          enabledBorder:OutlineInputBorder(
            borderSide:
            const BorderSide(width: 3, color: Colors.grey), //<-- SEE HERE
            borderRadius: BorderRadius.circular(50.0),
          ),


          border:  OutlineInputBorder(
            borderSide:
            const   BorderSide(width: 3, color: Colors.grey), //<-- SEE HERE
            borderRadius: BorderRadius.circular(50.0),
          ),

        ),
        cursorColor: Colors.grey,
        style:const TextStyle(color: Colors.white),

        onSaved: (value) {
          textSaved = value;
        },
          controller: UserNameController,
        validator: validator

      ),
    );
  }
}
