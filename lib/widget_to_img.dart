import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WidgetToImg {
  final GlobalKey key;

  WidgetToImg({@required this.key});

  /// Captura um [Widget] e seus filhos e transforma em um [Uint8List].
  ///
  /// Utilize um [RepaintBoundary] passando uma [GlobalKey] para informar o [Widget] a ser transformado.
  ///
  Future<Uint8List> capturePng() async {
    try {
      RenderRepaintBoundary boundary = key.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 8.0);

      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      Uint8List pngBytes = byteData.buffer.asUint8List();
      return pngBytes;
    } catch (e) {
      return null;
    }
  }
}
