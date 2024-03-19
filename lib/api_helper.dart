import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http_apis/home_model.dart';
import 'package:http/http.dart' as http;


class ApiHelper{

  final url = Uri.parse('https://jsonplaceholder.typicode.com/albums/');

  Future<List<HomeModel>> fetchData() async{
    final response = await http.get(url);
    if(response.statusCode == 200){
      final body = jsonDecode(response.body);
      print('get Data =====> $body');
      return List.from(body).map((e) => HomeModel.fromJson(e)).toList();
    }else{
      throw Exception('failed to load');
    }
  }


  Future<String> postData(String title,context) async{
        final response = await http.post(
            url, headers: {'Content-Type': 'application/json; charset=UTF-8'},
            body: jsonEncode({'title':title})
        );
        if(response.statusCode == 201){
            Map<String, dynamic> body = jsonDecode(response.body);
            print('data ===> ${body['title']}');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(body.toString())));
           return body['title'];
        }else{
           throw Exception('failed to load');
        }
  }

  //put
  Future<void> putData(String title, context) async{
    final response = await http.put(
        Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'title':title})
    );
    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);
      print('put====>$body');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(body.toString())));
    }else{
      throw Exception('failed to load');
    }

  }
  
  //delete
  Future<void> deleteData(int id,context) async{
    final response = await http.delete(
        Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    if(response.statusCode == 200){
      Map<String, dynamic> body = jsonDecode(response.body);
      print('delete====>$body');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(body.toString())));
    }
    else{
      throw Exception('failed to load');
    }
  }

}


