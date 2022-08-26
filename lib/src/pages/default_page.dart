import 'package:cmed_app/src/pages/home.dart';
import 'package:flutter/material.dart';

class defaultPage extends StatelessWidget {
  const defaultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            _image(),
            Divider(),
          ],
        )
      ),
    );
  }
  
 Widget _image() {
    return Column(
      children: <Widget>[
        Image(image: NetworkImage(
          'https://cdn-icons-png.flaticon.com/512/1256/1256586.png?w=740&t=st=1660514036~exp=1660514636~hmac=724179cbff2e2ad2a93a246db89822c67d4a465d3a51a5d2cb7ca25c88e69e62'),
          
        ),
      ],

    );
  }
  
_title() {
  RichText(
    text: TextSpan(
      children: const <TextSpan>[
        TextSpan(text: 'Página'),
        TextSpan(text: 'en'),
        TextSpan(text: 'Desarrollo', 
          style: TextStyle(fontWeight: FontWeight.bold, 
          color: Colors.blueAccent))
      ]
    ),
  );
}
}