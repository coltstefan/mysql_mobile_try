import 'package:flutter/material.dart';
import 'package:mysql_try/src/helpers/custon_text.dart';
import 'package:mysql_try/src/helpers/screen_navigation.dart';
import 'package:mysql_try/src/models/mysql.dart';
import 'dart:collection';

import 'package:mysql_try/src/screens/Products.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {

  var db = new Mysql();
  var offerId = [];
  var offerName = [];


  LinkedHashMap offers = new LinkedHashMap<int,String>();

  @override
  void initState(){
    db.getConnection().then((conn){
      String sql = 'select offer.id , offer.name from offer';
      conn.query(sql).then((results){
       for( var row in results) {
         setState(() {
           offerId.add(row[0]);
           print(offerId);
           offerName.add(row[1]);
           print(offerName);
           // offers.addAll({row[0] : row[1]});
           // print(offers.values);

         });
       }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(text: "Mobite", size: 20, color: Colors.white),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(text: "Available Offers" , size: 30, weight: FontWeight.bold,),
          ),
          SizedBox(height: 10),
          //CustomText(text: "${offerId}"),
          Padding(
            padding: const EdgeInsets.fromLTRB(8,8,8,10),
            child: Column(
                children: offerName.map((item) => GestureDetector(
                    onTap : () {

                      changeScreen(context, Products( restaurant: item));

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                       // width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                        ),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(8,30,8,8),
                                  child: Center(
                                    child: CustomText(text: "$item" , size: 20, weight: FontWeight.bold,),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ))).toList()
            ),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   //onPressed: _getOffers,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
