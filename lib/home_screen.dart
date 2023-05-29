import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var data ;
  Future<void> getUserApi () async {
   final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
   if(response.statusCode == 200){
     data = jsonDecode(response.body.toString());
   }else{

   }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('complexjason without using model'),
      ),
      body: Column(
        children: [
           Expanded(
             child: FutureBuilder(
               future:getUserApi (),
               builder: (context, snapshot){

                 if(snapshot.connectionState == ConnectionState.waiting){
                   return Text('Loading');

                 }else{
                   return ListView.builder(
                       itemCount: data.length,
                       itemBuilder: (context , index){

                     return Card(
                       child: Column(
                         children: [
                           ReusebleRow(title: 'name', value: data [index] ['name'].toString(),),
                           ReusebleRow(title: 'username', value: data [index] ['username'].toString(),),
                           ReusebleRow(title: 'email', value: data [index] ['email'].toString(),),
                           ReusebleRow(title: 'address', value: data [index] ['address']['street'].toString(),),
                           ReusebleRow(title: 'lat', value: data [index] ['address']['geo']['lat'].toString(),),
                           ReusebleRow(title: 'lng', value: data [index] ['address']['geo']['lng'].toString(),),

                         ],
                       ),
                     );
                   });
                 }

               },
             ),
           )
        ],
      ),
    );
  }
}

class ReusebleRow extends StatelessWidget {
  String title , value ;
  ReusebleRow({Key? key , required this.title , required this.value }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}

