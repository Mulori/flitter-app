import 'dart:io';
import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final int tipo; // Tipo da imagem
  final String caminho; // Caminho da imagem

  CustomImage({required this.tipo, required this.caminho});

  @override
  Widget build(BuildContext context) {
    Widget imagem;

    switch (tipo) {
      case 0:
        imagem = Image.asset(
          "assets/image/imgNotFound.png",
        );
        break;
      case 1:
        imagem = Image.file(
          File(caminho),
        );
        break;
      case 2:
        imagem = Image.network(
          caminho,
        );
        break;
      default:
        imagem =
            Container(); // Pode fornecer uma imagem padrão ou um container vazio
        break;
    }
    return imagem;
  }
}
