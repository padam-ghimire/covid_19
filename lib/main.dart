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
             _getWorldData(); 

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
           itemCount: lstCountry==null ? 0 :lstCountry[0]['countries_stat'].length,
           physics: NeverScrollableScrollPhysics(),
           itemBuilder:(context,index){
             return listItem(index);
           }
         )
       ]
     ),
      
    );
  
  }
   Widget listItem(int index){
     return Column(
       children: <Widget>[
         Center(
          //  child: Text(lstCountry[0]['countries_stat'][index]['country_name']),
         ),
         Row(

           children: <Widget>[
               Expanded(

                child: Container(
                
                 color: Colors.green,
                 
                 padding: EdgeInsets.all(30),
                 child: Column(
                 
                 children: <Widget>[
                   Text(lstCountry[0]['countries_stat'][index]['total_recovered'],style: TextStyle(color:Colors.white,fontSize:20),),
                   Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                   Text('Dead',style: TextStyle(color:Colors.white,fontSize:20),)
                 ],
               ),),
             ),


             Expanded(
                child: Container(
                 color: Colors.blueAccent,
                 padding: EdgeInsets.all(30),
                 child: Column(
                 
                 children: <Widget>[
                Text(lstCountry[0]['countries_stat'][index]['country_name'],style: TextStyle(color:Colors.white,fontSize:20),),

                   Text(lstCountry[0]['countries_stat'][index]['active_cases'],style: TextStyle(color:Colors.white,fontSize:20),),
                   Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                   Text('Infected',style: TextStyle(color:Colors.white,fontSize:20),)
                 ],
               ),),
             ),
           SizedBox(height: 20,),
             Expanded(
                child: Container(
                 color: Colors.red,
                 padding: EdgeInsets.all(30),
                 child: Column(
                 
                 children: <Widget>[
                   Text(lstCountry[0]['countries_stat'][index]['deaths'],style: TextStyle(color:Colors.white,fontSize:20),),
                   Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 5)),
                   Text('Dead',style: TextStyle(color:Colors.white,fontSize:20),)
                 ],
               ),),
             ),
             
           ],
           
           )
       ],
     );
   }
}

