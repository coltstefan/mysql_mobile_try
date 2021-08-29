import 'package:flutter/material.dart';
import 'package:mysql_try/src/helpers/custon_text.dart';
import 'package:mysql_try/src/models/mysql.dart';

class Products extends StatefulWidget {

  String restaurant;
  // var names = [];
  // var prices = [];
  // var stock = [];
  // Products({this.restaurant , this.names , this.prices , this.stock});
  Products({this.restaurant});


  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  var db = new Mysql();


  var names = [];
  var prices = [];
  var stocks = [];

  @override
  void initState(){


    db.getConnection().then((conn){
      // String sql = 'select  product.name , product.price , product.stock from offer left join product on offer.id = product.offer_id WHERE offer.name = ?',[item];
      conn.query('select  product.name , product.price , product.stock from offer left join product on offer.id = product.offer_id WHERE offer.name = ?',[widget.restaurant]).then((results){
        for( var row in results) {
          setState(() {
            names.add(row[0]);
            prices.add(row[1]);
            stocks.add(row[2]);
            print(names);

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
        backgroundColor: Colors.black,
        title: CustomText(text: "${widget.restaurant}", size: 20, color: Colors.white, weight: FontWeight.bold,),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Container(
            height: 230,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: names.length,
              itemBuilder: (_,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 230,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey[200]
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8,40,8,8),
                            child: Center(
                              child: CustomText(text: "${names[index]}", size: 20, weight: FontWeight.bold,),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(text: "Price: ${prices[index]} lei" , size: 17, weight: FontWeight.bold),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomText(text: "Stock: ${stocks[index]}",size: 17, weight: FontWeight.bold,),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
              },
            ),
          )
        ],
      ),
    );

  }
}
