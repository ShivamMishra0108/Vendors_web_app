import 'package:ecommerce_web_app/controller/category_controller.dart';
import 'package:ecommerce_web_app/controller/subCategory_controller.dart';
import 'package:ecommerce_web_app/models/category.dart';
import 'package:ecommerce_web_app/models/subCategory.dart';
import 'package:flutter/material.dart';

class SubcategoryWidget extends StatefulWidget {
   const SubcategoryWidget({super.key});

  @override
  State<SubcategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<SubcategoryWidget> {
  late Future<List<Subcategory>> futureCategories;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCategories = SubCategoryController().loadSubCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No categories"));
        } else {
          final subcategories = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            itemCount: subcategories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final Subcategory = subcategories[index];
              return Column(
                children: [
                  Image.network(Subcategory.image, height: 100, width: 100),
                  Text(Subcategory.subCategoryName),

                  
                ],
              );
            },
          );
        }
      },
    );
  }
}
