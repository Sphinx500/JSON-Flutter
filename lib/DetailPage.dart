import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'homePage.dart';
import 'main.dart';

class DetailPage extends StatelessWidget {

  final heroes hero;
  DetailPage(this.hero);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(hero.nombre),
          centerTitle: true,
          backgroundColor: Colors.purple,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.deepPurpleAccent,
        body: Stack(children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: hero.img,
              child: Container(
                height: 500.0,
                width: 550.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(hero.img),
                    fit: BoxFit.fitHeight
                  ),

                ),
              ),
            ),
          ),
          Positioned(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width - 20,
              left: 10.0,
              top: MediaQuery.of(context).size.height * 0.16,
              child: Card(
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: 70.0,
                        ),
                        Text(
                          hero.nombre,
                          style: TextStyle(fontSize: 37.0, color: Colors.white),
                        ),
                        Text('IDENTIDAD: ${hero.identidad}',
                            style: TextStyle(color: Colors.white),
                        ),
                        Text('EDAD: ${hero.edad}',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text('ALTURA: ${hero.altura}',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text('GENERO: ${hero.genero}',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text('DESCRIPCION: ${hero.descripcion}',
                          style: TextStyle(color: Colors.white),
                        ),
                      ]))),
        ]),
    );

  }
}
