import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

main(){
  runApp(
    MaterialApp(
      title:"Corona App",
      debugShowCheckedModeBanner: false,
      home: Covid(),
    )
  );
}

class Covid extends StatefulWidget {
  @override
  _CovidState createState() => _CovidState();
}

class _CovidState extends State<Covid> {


bool loading = true;
List lstCountry;

Future <String> _getWorldData() async{

  var response = await http.get('https://brp.com.np/covid/country.php');
  var getData = json.decode(response.body);

  if(this.mounted){


    setState(() {
      loading = false;
      lstCountry= [getData];
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: (){

          })
        ],
        title:Text('Covid-2019'),
      ),
     body: ListView(
       padding:EdgeInsets.all(5),
       children:<Widget>[
         loading ? Center(child: CircularProgressIndicator()) :
         ListView.builder(
           shrinkWrap: true,
           itemCount: lstCountry==null ? 0 :lstCountry.length,
           physics: NeverScrollableScrollPhysics(),
           itemBuilder:(context,index){
             return listItem();
           }
         )
       ]
     ),
      
    );
  }
}