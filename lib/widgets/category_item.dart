// ignore_for_file: unused_field, implementation_imports, implementation_imports, duplicate_ignore, prefer_const_constructors, unnecessary_import, sized_box_for_whitespace, avoid_unnecessary_containers, use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:nanirecruitment/models/category_model.dart' as it;
import 'package:nanirecruitment/providers/category_section.dart' as item;
import 'package:nanirecruitment/screens/jobs_screen.dart';
import 'package:provider/provider.dart';

class CategoryCard extends StatelessWidget {
  final item.CategoryModel category;
  const CategoryCard(
      this.category,
  );
  @override
  Widget build(BuildContext context) {
    // final category = Provider.of<CategoryModel>(context, listen: false);
    return InkWell(
      onTap: () => 
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (ctx) => JobsScreen(id: category.id),
      //   ),
      // ), 
      // Navigator.of(context).pushReplacementNamed(
      //         JobsScreen.routeName,
      //         arguments: category.id,
      //       ),      
       Navigator.pushNamed(
                  context,
                  JobsScreen.routeName,
                  arguments: 
                  category.id,
                  ),         
      child:  Container(
      child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Card(       
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 80,
                width: 150,
                padding: EdgeInsets.all(5.0),
                child: Center(
                child:  Text(
                    category.name,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    // style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              Container(
                height: 80,
                width: 90,
                decoration: BoxDecoration(
                    gradient: RadialGradient(
                        colors:const [Color(0xffFCE183), Color(0xffF68D7F)],
                        center: Alignment(0, 0),
                        radius: 0.8,
                        focal: Alignment(0, 0),
                        focalRadius: 0.1)),
                padding: EdgeInsets.all(8.0),
                child: Center(
                child:  Expanded(
                  child:FadeInImage(
              placeholder: AssetImage('assets/sliderimages/00.jpg'), image: NetworkImage(category.imageUrl),))
                ),
              )
            ],
          ),
        ),
      ),
    )
    )
   );
  }
}
