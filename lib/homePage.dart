import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'DetailPage.dart';
import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';


class homePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<homePage> {

  //Metodo asincrono para leer el JSON
  Future<String> _loadAsset() async {
    return await rootBundle.loadString('json_assets/personajes.json');
  }

  Future<List<heroes>> _getHeroes() async {
    String jsonString = await _loadAsset();
    var Data = json.decode(jsonString);
    print(Data.toString());


    List<heroes> heros = [];
    for (var h in Data) {
      heroes he = heroes(h["img"], h["nombre"], h["identidad"], h["edad"],
          h["altura"], h["genero"], h["descripcion"]);
      heros.add(he);
    }
    print("Numero de elementos");
    print(heros.length);
    return heros;
  }
  String searchString = "";
  bool _isSearching = false;
  final searchController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  AudioPlayer audioPlayer;
  AudioCache audioCache;  

  final audioname = "avengers.mp3";

  @override
  void initState() {
    super.initState();


    audioPlayer = AudioPlayer();
    audioCache = AudioCache();
    var loop = 1;

    setState(() {
      audioCache.play(audioname);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: _isSearching
            ? TextField(
          decoration: InputDecoration(
              hintText: "Buscando",
              icon: Icon(Icons.search)),
          onChanged: (value) {
            setState(() {
              searchString = value;
            });
          },
          controller: searchController,
        )
            : Text("Superheroes"),
        actions: <Widget>[
          !_isSearching
              ? IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                searchString = "";
                this._isSearching = !this._isSearching;
              });
            },
          )
              : IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                this._isSearching = !this._isSearching;
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          child: FutureBuilder(
            future: _getHeroes(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Cargando..."),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return snapshot.data[index].nombre
                        .contains(searchString)
                        ? ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            snapshot.data[index].img.toString()),
                      ),
                      title: Text(snapshot.data[index].nombre
                          .toString()
                          .toUpperCase()),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                    snapshot.data[index])));
                      },
                    )
                        : Container();
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class heroes {
  final String img;
  final String nombre;
  final String identidad;
  final String edad;
  final String altura;
  final String genero;
  final String descripcion;

  heroes(this.img,this.nombre,this.identidad, this.edad, this.altura, this.genero, this.descripcion);
}