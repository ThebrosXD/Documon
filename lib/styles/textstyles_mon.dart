import 'package:flutter/material.dart';

class TextstylesMon {
  static const TextStyle titulo = TextStyle(
    color: Color.fromARGB(255, 255, 255, 255),
    fontWeight: FontWeight.bold,
    fontSize: 49,
    fontStyle: FontStyle.italic,
  );
  static const TextStyle texto = TextStyle(
    color: Color.fromARGB(255, 255, 255, 255),
    fontSize: 15,
  );
  static const TextStyle titulo2 = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 34,
  );
  static const TextStyle textoBar = TextStyle(
    color: Color.fromARGB(255, 255, 255, 255),
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );
  static const TextStyle nombrePokemones = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  static const TextStyle tituloTarjeta = TextStyle(
    color: Color.fromARGB(255, 0, 0, 0),
    fontWeight: FontWeight.bold,
    fontSize: 34,
    shadows: <Shadow>[
      Shadow(offset: Offset(3, 2), color: Color.fromARGB(111, 175, 175, 175)),
    ],
    fontFamily: 'BespokeSlab'

  );
  static const TextStyle textoTarjetas = TextStyle(
    color: Color.fromARGB(255, 0, 0, 0),
    fontSize: 15,
  );

  static const TextStyle textoCategoriaTarjeta = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );
}
