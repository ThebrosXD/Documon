import 'dart:convert';

import 'package:documon/data/model/pokemong_response.dart';
import 'package:documon/data/model/pokemones_response.dart';
import 'package:documon/method/type_on_spanish.dart';
import 'package:http/http.dart' as http;

class Repositorio {

  
  Future<PokemongResponse?> fetchPokemonesResponseInfo(String result) async {
    final response = await http.get(
      Uri.parse("https://pokeapi.co/api/v2/pokemon/?limit=1000"),
    );

    if (response.statusCode == 200) {
      var decoJson = jsonDecode(response.body);
      var pokemonesResponse = PokemongResponse.fromJson(decoJson);
      var filtrados = pokemonesResponse.result
          .where((poke) => poke.name.startsWith(result.toLowerCase()))
          .map((poke) {
            // Obtener el ID desde la URL: https://pokeapi.co/api/v2/pokemon/25/
            final id = poke.url.split("/")[6];
            final imageUrl =
                "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png";
            final imageGif = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/$id.gif";
            return PokemonesResponse(
              name: poke.name,
              url: poke.url,
              imageUrl: imageUrl,
              imageGif: imageGif
            );
          })
          .toList();

      return PokemongResponse(result: filtrados);
    } else {
      throw Exception("Algo paso! ${response.statusCode}");
    }
  }

  Future<String> fetchPokemonDescription(String name) async {
    final response = await http.get(
      Uri.parse("https://pokeapi.co/api/v2/pokemon-species/$name"),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      // Filtrar la primera descripción en inglés
      var flavorTextEntries = data["flavor_text_entries"] as List;
      var flavorText = flavorTextEntries.firstWhere(
        (entry) => entry["language"]["name"] == "es",
        orElse: () => null,
      );

      return flavorText != null
          ? flavorText["flavor_text"]
                .replaceAll("\n", " ")
                .replaceAll("\f", " ")
          : "No description available.";
    } else {
      throw Exception("Error al traer la descripción");
    }
  }

  Future<List<String>> fetchTypes(String name) async {
    final response = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/$name/"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final typesData = data["types"] as List;
      return typesData.map<String>((t) => Typeonspanish.traductorTipos(t["type"]["name"])).toList();
    } else {
      throw Exception("Error al obtener tipos");
    }
  }
}
