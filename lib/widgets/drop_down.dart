import 'package:chat_me_final/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../providers/models_provider.dart';

class ModelsDropDownWidget extends StatefulWidget {
  const ModelsDropDownWidget({Key? key}) : super(key: key);

  @override
  State<ModelsDropDownWidget> createState() => _ModelsDropDownWidgetState();
}

class _ModelsDropDownWidgetState extends State<ModelsDropDownWidget> {
  String? currentModels;

  @override
  Widget build(BuildContext context) {
    final modelsProviders =Provider.of<ModelsProvider>(context,listen: false);
    currentModels = modelsProviders.getCurrentModel;
    return FutureBuilder(
        future: modelsProviders.getAllModels(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: TextWidget(
                lable: snapshot.error.toString(),
              ),
            );
          }
          return snapshot.data == null || snapshot.data!.isEmpty
              ? SizedBox.shrink()
              : DropdownButton(
            value: currentModels,

            iconEnabledColor: Colors.white,
                  dropdownColor: scaffoldBackgroundColor,
                  items: List<DropdownMenuItem<String>>.generate(
                    snapshot.data!.length
                    , (index) => DropdownMenuItem(
                      value: snapshot.data![index].id,
                      child: TextWidget(
                    lable: snapshot.data![index].id,
                    fontSize: 15,
                  )
                  )
                  ),
                  onChanged: (value) {
                    setState(() {
                      currentModels = value.toString();
                    });
                    modelsProviders.setCurrentModel(value.toString());
                  });
        });
  }
}
