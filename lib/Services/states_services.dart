import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Model/WorldStatesModel.dart';
import 'Utilities/app_url.dart';
class StatesServices{
  Future <WorldStatesModel> FetchWordlSatesRecord() async{
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if(response.statusCode == 200)
      {
        var data = jsonDecode(response.body);
        return WorldStatesModel.fromJson(data);

      }
    else
      {
        throw Exception('Eroor');
      }
  }

  Future <List<dynamic>> CountriesListApi() async{
    var data ;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if(response.statusCode == 200)
    {
       data = jsonDecode(response.body);
      return data;

    }
    else
    {
      throw Exception('Eroor');
    }
  }
}