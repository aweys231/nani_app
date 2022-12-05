// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_final_fields, unused_field, avoid_print, dead_code, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:nanirecruitment/widgets/category_item.dart';

import 'package:provider/provider.dart';

import '../providers/category_section.dart' ;


class Item extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<Item> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<Item> {
  late Future _ordersFuture;
  Future _obtainOrdersFuture() {
    return Provider.of<Category_Section>(context, listen: false).fetchAndSetAllCategory();
  }

  @override
  void initState() {
    _ordersFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: 
    FutureBuilder(
          future: _ordersFuture,
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                return Center(child: Text('An error Accour'));
                print(dataSnapshot.error);
              } else {
                return
                Container(
                 
         child: Padding(padding:EdgeInsets.symmetric(
                      horizontal: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            // width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                          margin: EdgeInsets.all(5.0),                        
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width,
                          child:
                 Consumer<Category_Section>(
                  
                  builder: (ctx, orderData, child) =>Expanded(
                    
                      child:
                    ListView.builder(
                      
                    // scrollDirection: Axis.horizontal,
                    itemCount: orderData.categories.length,
                    itemBuilder: (ctx, i) => CategoryCard(orderData.categories[i]),
                  ),
                  // GridView.count(
                  //         primary: true,
                  //         crossAxisCount: 2,
                  //         childAspectRatio: 0.80,
                  //         children: List.generate(orderData.categories.length, (i) => CategoryCard(orderData.categories[i])),
                  // ),
                  )
                )
                  ),
              ]
              ),
              )
              )
              )
              );

              }
            }
          }),
    );
  }
}
