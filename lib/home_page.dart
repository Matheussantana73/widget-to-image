import 'dart:typed_data';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:screenshot_widget/widget_to_img.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey _globalKey = GlobalKey();
  Uint8List _uint8List;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WTI'),
        centerTitle: true,
      ),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.image),
        onPressed: _onPressed,
      ),
    );
  }

  _onPressed() async {
    WidgetToImg widgetToPng = WidgetToImg(key: _globalKey);
    Uint8List imageReturn = await widgetToPng.capturePng();

    setState(() {
      _uint8List = imageReturn;
    });

    // Caso queira compartilhar a imagem
    Share.file('Widget', 'widget.jpg', imageReturn, 'image/jpg');
  }

  Widget _body() {
    return Container(
      child: ListView(
        children: <Widget>[
          Text('Widget', style: TextStyle(fontSize: 20)),
          Center(
            // Widget que será trasformada
            child: RepaintBoundary(
              // Key de controle
              key: _globalKey,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.indigoAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.query_builder),
                    Text('Text 1'),
                    Text('Text 2'),
                    Text('Text 3'),
                    Text('Text 4'),
                    CircleAvatar(
                      child: Icon(Icons.airline_seat_individual_suite),
                    )
                  ],
                ),
              ),
            ),
          ),
          Divider(
            height: 20,
          ),
          Text('Imagem', style: TextStyle(fontSize: 20)),
          // Imagem que foi capturada
          _uint8List != null ? Image.memory(_uint8List) : Container(),
        ],
      ),
    );
  }
}
