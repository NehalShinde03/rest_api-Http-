import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_apis/home_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    Future<HomeModel?>? futureObj;

    return Scaffold(
      body: SizedBox(

        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FutureBuilder<HomeModel?>(
              future: futureObj,
              builder: (context, snapshot) {

                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(

                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator());
                } else if(snapshot.connectionState == ConnectionState.none){
                  return const SizedBox();
                } else{
                  if(snapshot.hasData){
                    return buildDataWidget(context, snapshot);
                  }
                  else if(snapshot.hasError){
                    return Text('${snapshot.error}');
                  }
                  else{
                    return const SizedBox();
                  }
                }
              },
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          futureObj = fetchData();
                          print(futureObj);
                        });
                      },
                      child: const Text('GET')
                  ),
                  ElevatedButton(
                      onPressed: (){
                        setState(() {
                          futureObj = createData("create","for new Data creation");
                        });
                      },
                      child: const Text('POST')
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          futureObj = updateData('update','for data updation');
                        });
                      },
                      child: const Text('PUT')
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          futureObj = deleteData();
                        });
                      },
                      child: const Text('DELETE')
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDataWidget(BuildContext context, AsyncSnapshot snapshot) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(snapshot.data.title, style: const TextStyle(fontSize: 20)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(snapshot.data.body, style: const TextStyle(fontSize: 20)),
        ),
      ],
    );
  }
}


// GET API CALL
Future<HomeModel> fetchData() async{

  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  final resp = await http.get(url);

  if(resp.statusCode == 200){
    return HomeModel.fromJson(json.decode(resp.body));
  }else{
    throw Exception('failed to load');
  }

}

/////////////////////POST API CALL

Future<HomeModel> createData(String title, String desc) async{
  Map<String, dynamic> req = {
    'title': title.toString(),
    'desc': desc.toString(),
    'userId': 1
  };

  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final resp = await http.post(url, body: req);
  if(resp.statusCode ==  201){
    return HomeModel.fromJson(jsonDecode(resp.body));
  }else{
    throw Exception('failed to load');
  }
}

/////////////////PUT API CALL

Future<HomeModel> updateData(String title, String desc) async{
  Map<String, dynamic> req = {
    'id' : 1,
    'title': title.toString(),
    'desc': desc.toString(),
    'userId': 111
  };
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final resp = await http.put(url, body: req);

  if(resp.statusCode == 201){
    return HomeModel.fromJson(jsonDecode(resp.body));
  }else{
    throw Exception('fail to load');
  }
}

/////////////////DELETE API CALL

Future<HomeModel?>? deleteData() async{
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  final resp = await http.delete(url);

  if(resp.statusCode == 200){
    return null;
  }
  else{
    throw Exception('failed to load data');
  }
}