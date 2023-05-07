import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:http/http.dart' as http;

import '../constants/api_const.dart';
import '../models/chat_model.dart';
import '../models/models_model.dart';

class  ApiService{
  static Future<List<ModelsModel>> getModels()async{
    try{
     var response=await http.get(Uri.parse('$BASE_URL/models'),
          headers: { 'Authorization': 'Bearer $API_KEY'}
      );
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null){
        print('jsonResponse[error] ${jsonResponse['error']['message']}');

        throw HttpException(jsonResponse['error']['message']);
      }
     print('jsonResponse  $jsonResponse');
      List temp = [];
      for(var value in jsonResponse['data']){
        temp.add(value);
        log('temp ${value['id']}');

      }
      return ModelsModel.modelsFromSnapshot(temp);

    }catch(error){
      print('error  $error');
      log('error  $error');
      rethrow;
    }

  }
//send Message using ChatGPT Api
  static Future<List<ChatModel >> sendMessageGPT ({required String message,required String modelId})async{
    try{
      log('modelId $modelId');
      var response=await http.post( Uri.parse('$BASE_URL/chat/completions'),
          headers: { 'Authorization': 'Bearer $API_KEY','Content-Type':'application/json'}
          ,body: jsonEncode({
            "model": modelId,
            "messages": [{"role": "user",
              "content": message}],
          },
          )
      );
      // Map jsonResponse = jsonDecode(response.body);
      Map jsonResponse=jsonDecode(utf8.decode(response.bodyBytes));


      if (jsonResponse['error'] != null){
        print('jsonResponse[error] ${jsonResponse['error']['message']}');

        throw HttpException(jsonResponse['error']['message']);
      }
      List<ChatModel>chatlist=[];

    if(jsonResponse['choices'].length>0){
      log('jsonResponse[choices] text${jsonResponse['choices'][0]['text']}');
   chatlist=List.generate(jsonResponse['choices'].length, (index) => ChatModel(
       msg: jsonResponse['choices'][index]['message']['content'],
       chatIndex: 1));

    }
      return chatlist;

    }catch(error){
      print('error  $error');
      log('error  $error');
      rethrow;
    }

  }




}