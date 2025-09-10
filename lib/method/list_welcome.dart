import 'dart:math';

class ListWelcome {
  List<String> tBievenidos=[
    "¡Bienvenido Entrenador! El mundo Pokémon te espera, prepárate para tu aventura.",
    "¡Has llegado a la Liga Pokémon! Atrapa, entrena y conviértete en el mejor de todos.",
    "¡Bienvenido a la región! Explora montañas, bosques y mares.",
    "¡Bienvenido! El viaje hacia convertirte en Maestro Pokémon comienza hoy.",
    "¡Saludos! En este mundo lleno de criaturas mágicas, tu destino está por escribirse.",
    "¿Sabías que Pikachu fue el primer amigo de Ash? ¡Tú también encontrarás a tu compañero ideal!",
    "¿Sabías que algunos Pokémon evolucionan cuando forman un lazo especial contigo?",
    "¿Sabías que cada entrenador empieza su viaje con un solo Pokémon?",
  ];

  String getMessageRandom(){
    final random_ = Random();
    return tBievenidos[random_.nextInt(tBievenidos.length)];
  }
}