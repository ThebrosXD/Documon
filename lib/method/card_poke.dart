import 'package:flutter/material.dart';

class Cardpoke {
  Color cardColor(List<String> types){
    if(types.isEmpty){
      return Colors.white;
    }

    switch (types.first) {
      case "Planta":
        return  const Color.fromARGB(255, 62, 220, 0);
      case "Veneno":
        return const Color.fromARGB(255, 137, 27, 255);
      case "Fuego":
        return const Color.fromARGB(255, 255, 153, 28);
      case "Agua":
        return const Color.fromARGB(255, 101, 196, 255);
      case "Normal":
        return const Color.fromARGB(255, 214, 214, 214);
      case "Hielo":
        return const Color.fromARGB(255, 155, 238, 255);
      case "Eléctrico":
        return const Color.fromARGB(255, 243, 255, 78);
      case "Roca":
        return const Color.fromARGB(255, 79, 79, 79);
      case "Hada":
        return const Color.fromARGB(255, 255, 155, 247);
      case "Tierra":
        return const Color.fromARGB(255, 127, 85, 55);
      case "Psíquico":
        return const Color.fromARGB(255, 124, 50, 156);
      case "Acero":
        return const Color.fromARGB(172, 193, 193, 193);
      case "Dragon":
        return const Color.fromARGB(255, 74, 82, 156);
      default:
        return const Color.fromARGB(255, 169, 153, 153);
    }
  }
}