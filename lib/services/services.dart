import 'package:chat_me_final/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../providers/auth_provider.dart';
import '../screens/sign_up_screen.dart';
import '../widgets/drop_down.dart';
import '../widgets/text_widget.dart';

class Services{

  static Future<void> showModalSheet({required BuildContext context})async{
    final authProvider = Provider.of<AuthProvider>(context,listen: false);

    await showModalBottomSheet(
        shape:const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            )
        ),
        backgroundColor: scaffoldBackgroundColor,
        context: context, builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: TextWidget(
                      lable: 'Chosen Model:',
                      fontSize: 16,

                    )
                ),
                const Flexible(flex: 2,
                    child: ModelsDropDownWidget())
              ],
            ),
            IconButton(onPressed: ()async{
              authProvider.signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) =>LoginScreen()
              ));



            }, icon: Icon(Icons.logout,color: Colors.white,size: 20,))

          ],
        ),
      );
    });
  }
}