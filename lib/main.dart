import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}