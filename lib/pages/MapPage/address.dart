import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taxirocha/bloc/placeBloc.dart';
import 'package:taxirocha/models/place.dart';

import '../../util.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  PlaceBloc _placeBloc;

  @override
  void initState() {
    _placeBloc = PlaceBloc();
    super.initState();
  }

  @override
  void dispose() {
    _placeBloc.dispose();
    super.dispose();
  }

  _getPlaces(txt) {
    _placeBloc.searchPlace(txt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Locais de partida'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {
          Navigator.pop(context);
        }),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(0.0, 10.0),
                  blurRadius: 10.0,
                ),
              ],
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15))
            ),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.5, color: Color(0XFFababab))
                      ),
                      hintText: 'Esse e seu local',
                      prefixIcon: Icon(Icons.my_location,size: 17,),
                      border: OutlineInputBorder()

                  ),

                ),
                SizedBox(height: 10),
                TextField(
//                  autofocus: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.5, color: Color(0XFFababab))
                      ),
                      hintText: 'Para onde?',
                      prefixIcon: Icon(Icons.place, size: 17),
                      border: OutlineInputBorder(),
                  ),
                  onChanged: _getPlaces
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(child: Container(),),
                    ButtonTheme(
                      minWidth: 60,
                      height: 60,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      child: RaisedButton(
                          child: Icon(Icons.arrow_forward, color: Colors.white,),
                          onPressed:() {},

                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20,),
          StreamBuilder(
            stream: _placeBloc.placeStream(),
            builder: (BuildContext context, AsyncSnapshot snap) {
              List<Place> places = snap.data;
              if (snap.data == null) {
                return Container();
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: places.length,
                  itemBuilder: (BuildContext c, int i) {
                    return ListTile(
                      leading: Icon(Icons.place, color: primaryColor),
                      title: Text(places[i].name),
                      subtitle: Text(places[i].address),
                      onTap: () {
                        print('luan');
                      },
                    );
                  },
                ),
              );
            }
          )


        ],
      ),
    );
  }
}

