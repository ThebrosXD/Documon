import 'package:documon/data/repositorio.dart';
import 'package:documon/method/card_poke.dart';
import 'package:documon/method/fist_uppercase.dart';
import 'package:documon/styles/colors_mon.dart';
import 'package:documon/styles/textstyles_mon.dart';
import 'package:flutter/material.dart';

class ScreenSelectpMon extends StatefulWidget {
  final String nameP;
  final String imageP;
  final String gifP;
  const ScreenSelectpMon({
    super.key,
    required this.nameP,
    required this.imageP,
    required this.gifP,
  });

  @override
  State<ScreenSelectpMon> createState() => _ScreenSelectpMon();
}

class _ScreenSelectpMon extends State<ScreenSelectpMon> {
  Cardpoke cardPoke = Cardpoke();
  Repositorio repo = Repositorio();

  @override
  void initState() {
    super.initState();
    loadDescriptio();
  }

  FistUppercase firstUpper = FistUppercase();
  String descripcion = "";
  List<String> types = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarSelect(),
      backgroundColor: ColorsMon.secundary,
      body: Container(
        decoration: BoxDecoration(
          color: cardPoke.cardColor(types),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                alignment: Alignment.center,
                child: Text(widget.nameP, style: TextstylesMon.tituloTarjeta),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Image.network(
                widget.gifP, //imagen del pokemon seleccionado
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    widget.imageP,
                    height: 200,
                    width: 240,
                    fit: BoxFit.cover,
                  );
                },
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 20, top: 15),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(-3, 3),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                      ),
                      height: 140,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, top: 10),
                        child: Text(
                          "Descripcion: ",
                          style: TextstylesMon.textoCategoriaTarjeta,
                          textScaler: TextScaler.linear(1),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        height: 140,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            style: TextstylesMon.textoTarjetas,
                            descripcion,
                          ),
                        ), //descripcion del pokemon
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 30),
              child: Container(
                width: 190,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(-3, 3),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, top: 10),
                        child: SizedBox(
                          height: 50,
                          width: 70,
                          child: Text(
                            "Tipo: ",
                            style: TextstylesMon.textoCategoriaTarjeta,
                            textScaler: TextScaler.linear(1),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        border: Border(
                          left: BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 4,
                          top: 5,
                          bottom: 5,
                        ),
                        child: SizedBox(
                          height: 50,
                          width: 100,
                          child: Wrap(
                            children: types.map((t) {
                              return Row(
                                children: [
                                  Image.asset(
                                    "assets/image/$t.png",
                                    fit: BoxFit.contain,
                                    height: 25,
                                    width: 25,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Text("⚪");
                                    },
                                  ),
                                  Text(
                                    " $t",
                                    style: TextstylesMon.textoTarjetas,
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appbarSelect() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      title: Text("Regresar", style: TextstylesMon.textoBar),
      backgroundColor: ColorsMon.primary,
    );
  }

  Future<void> loadDescriptio() async {
    try {
      Repositorio repo = Repositorio();

      final desc = await repo.fetchPokemonDescription(
        widget.nameP.toLowerCase(),
      );
      final type = await repo.fetchTypes(widget.nameP.toLowerCase());
      setState(() {
        descripcion = desc;
        types = type;
      });
    } catch (e) {
      setState(() {
        descripcion = "No se obtuvieron resultados.";
      });
    }
  }
}
