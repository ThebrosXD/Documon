class Typeonspanish {
  static const Map<String, String> tiposES = {
  "normal": "Normal",
  "fire": "Fuego",
  "water": "Agua",
  "electric": "Eléctrico",
  "grass": "Planta",
  "ice": "Hielo",
  "fighting": "Lucha",
  "poison": "Veneno",
  "ground": "Tierra",
  "flying": "Volador",
  "psychic": "Psíquico",
  "bug": "Bicho",
  "rock": "Roca",
  "ghost": "Fantasma",
  "dragon": "Dragón",
  "dark": "Siniestro",
  "steel": "Acero",
  "fairy": "Hada",
  };

  static String traductorTipos(String tipo){
    return tiposES[tipo]?? tipo;
  }
}