import 'dart:math';

import 'package:documon/data/model/pokemong_response.dart';
import 'package:documon/data/model/pokemones_response.dart';
import 'package:documon/data/repositorio.dart';
import 'package:documon/method/fist_uppercase.dart';
import 'package:documon/method/list_welcome.dart';
import 'package:documon/screens/screen_select_pmon.dart';
import 'package:documon/styles/colors_mon.dart';
import 'package:documon/styles/textstyles_mon.dart';
import 'package:flutter/material.dart';

class ScreenMenuMon extends StatefulWidget {
  const ScreenMenuMon({super.key});

  @override
  State<ScreenMenuMon> createState() => _ScreenMenuMonState();
}

class _ScreenMenuMonState extends State<ScreenMenuMon> {
  Future<PokemongResponse?>? _pokemonInfo;
  Repositorio repositorio = Repositorio();
  FistUppercase fristUpper =
      FistUppercase(); //clase para convertir la primera letra en mayuscula
  ListWelcome listBienvenido = ListWelcome();
  String nameP = "";

  @override
  void initState() {
    super.initState();
    _pokemonInfo = repositorio.fetchPokemonesResponseInfo("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 190,
            width: 500,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [ColorsMon.primary, ColorsMon.secundary],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bienvenido',
                  textAlign: TextAlign.center,
                  style: TextstylesMon.titulo,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      pokemonWelcome(),
                      width: 80,
                      height: 70,
                      fit: BoxFit.contain,
                    ),
                    Container(
                      height: 78,
                      width: 250,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 38, 7, 105),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 9, top: 4, right: 9, bottom: 4),
                        child: Text(
                          listBienvenido.getMessageRandom(),
                          style: TextstylesMon.nombrePokemones,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: ColorsMon.secundary,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                      bottom: 10,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        hintText: "Bulbasur",
                        hintStyle: TextstylesMon.texto,
                        labelText: "Buscar Pokemon",
                        labelStyle: TextstylesMon.texto,
                      ),
                      style: TextstylesMon.texto,
                      onChanged: (text) {
                        setState(() {
                          _pokemonInfo = repositorio.fetchPokemonesResponseInfo(
                            text,
                          );
                        });
                      },
                    ),
                  ),
                  listPoke(), //Obtiene los datos de la apiPoke y las crea en un gridView
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder<PokemongResponse?> listPoke() {
    return FutureBuilder(
      future: _pokemonInfo,
      builder: (context, snapchot) {
        if (snapchot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapchot.hasError) {
          return Text("Error ${snapchot.hasError}");
        } else if (snapchot.hasData) {
          var pokeList = snapchot.data?.result;
          return Expanded(
            child: GridView.builder(
              itemCount: pokeList?.length ?? 0,
              itemBuilder: (context, index) {
                if (pokeList != null) {
                  return itemPoke(
                    pokeList[index],
                  ); //Contenedor de los pokemones
                } else {
                  return null;
                }
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                childAspectRatio: 0.8,
              ),
            ),
          );
        } else {
          return Text("No hay resultados");
        }
      },
    );
  }

  //Contenedor/diseno de la lista de los pokemones que se obtienen de la api
  Container itemPoke(PokemonesResponse pokeList) => Container(
    margin: EdgeInsets.only(bottom: 10, right: 4, left: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: ColorsMon.primary,
    ),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScreenSelectpMon(
              gifP: pokeList.imageGif??"",
              nameP: fristUpper.firstLetraMayuscula(pokeList.name),
              imageP: pokeList.imageUrl ?? "",
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Image.network(
              pokeList.imageUrl ?? "",
              height: 95,
              width: double.infinity,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              fristUpper.firstLetraMayuscula(pokeList.name),
              maxLines: 2,
              style: TextstylesMon.nombrePokemones,
              textScaler: TextScaler.linear(1),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
  
  String pokemonWelcome() {
      Random r = Random();

    List<String> pWelcome = [
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/1.gif",
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/4.gif",
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/7.gif",
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/10.gif",
    ];
      return pWelcome[r.nextInt(pWelcome.length)];
  }
}
