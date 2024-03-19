import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_apis/api_helper.dart';
import 'package:http_apis/common_widget/common_button.dart';
import 'package:http_apis/common_widget/common_text.dart';
import 'package:http_apis/home_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);


  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  late Future<List<dynamic>> apiHelper;

  @override
  initState(){
    super.initState();
    apiHelper=ApiHelper().fetchData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(text: 'HTTP'),
      ),
      body: Column(
        children: [

          Expanded(
            child: FutureBuilder<List<dynamic>>(
                future: apiHelper,
                builder: (context, snapshot){

                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if(snapshot.hasError && snapshot.connectionState == ConnectionState.none){
                    return Text(snapshot.hasError.toString());
                  }
                  else{
                    return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder:(context,index){
                          return ListTile(
                            leading: CircleAvatar(child: CommonText(text: snapshot.data?[index].id.toString())),
                            title: CommonText(text: snapshot.data?[index].title),
                          );
                        });
                  }
                }
            ),
          ),

          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //
                // CommonButton(buttonText: 'Get',onPressed: (){
                //   fetchData();
                // }),

                CommonButton(buttonText: 'Post',onPressed: (){
                  ApiHelper().postData("nehal",context);
                }),

                CommonButton(buttonText: 'Put',onPressed: (){
                    ApiHelper().putData("nehal",context);
                }),

                CommonButton(buttonText: 'Delete',onPressed: (){
                  ApiHelper().deleteData(2,context);
                }),

              ],
            ),
          ),

        ],
      ),
    );
  }

}





/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_apis/common_widget/common_button.dart';
import 'package:http_apis/common_widget/common_text.dart';
import 'package:http_apis/home_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);


  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  late Future<List<HomeModel>> future;

  @override
  initState(){
    super.initState();
    future=fetchData();
  }

  Future<List<HomeModel>> fetchData() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/'));
    if(response.statusCode == 200){
      return List.from(jsonDecode(response.body)).map((e) => HomeModel.fromJson(e)).toList();
    }else{
      throw Exception('failed to load');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Expanded(
            child: FutureBuilder<List<HomeModel>>(
                future: future,
                builder: (context, snapshot){

                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if(snapshot.hasError && snapshot.connectionState == ConnectionState.none){
                    return Text(snapshot.hasError.toString());
                  }
                  else{
                    return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder:(context,index){
                          return ListTile(
                            leading: CircleAvatar(child: CommonText(text: snapshot.data?[index].id.toString())),
                            title: CommonText(text: snapshot.data?[index].title),
                          );
                        });
                  }
                }
            ),
          ),

          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //
                // CommonButton(buttonText: 'Get',onPressed: (){
                //   fetchData();
                // }),

                CommonButton(buttonText: 'Get',onPressed: (){
                  future = fetchData();
                }),
                CommonButton(buttonText: 'Post',onPressed: (){}),
                CommonButton(buttonText: 'Put',onPressed: (){}),
                CommonButton(buttonText: 'Delete',onPressed: (){}),

              ],
            ),
          ),

        ],
      ),
    );
  }

}*/