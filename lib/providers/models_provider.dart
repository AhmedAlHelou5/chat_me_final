
import 'package:flutter/material.dart';

import '../models/models_model.dart';
import '../services/api_service.dart';

class ModelsProvider with ChangeNotifier {
// String currentModel = 'text-davinci-003';
String currentModel = 'gpt-3.5-turbo-0301';

String get getCurrentModel{
  return currentModel;
}

void setCurrentModel (String newModel){
  currentModel =  newModel;
  notifyListeners();
}
List<ModelsModel> modelList=[];

List<ModelsModel> get getModelsList{
  return modelList;
}

Future<List<ModelsModel>> getAllModels()async{
  modelList = await ApiService.getModels();
  return modelList;
}

}