import 'package:documon/data/model/pokemones_response.dart';

class PokemongResponse {
  final List<PokemonesResponse> result;

  PokemongResponse({required this.result});

  factory PokemongResponse.fromJson(Map<String, dynamic> json){

    var list = json["results"] as List;
    List<PokemonesResponse> pokeList= list.map((poke) => PokemonesResponse.fromJson(poke)).toList();

    return PokemongResponse(result: pokeList);
  }

}