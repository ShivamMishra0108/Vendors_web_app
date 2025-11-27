import 'package:ecommerce_web_app/controller/category_controller.dart';
import 'package:ecommerce_web_app/controller/subCategory_controller.dart';
import 'package:ecommerce_web_app/models/category.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SubcategoryScreen extends StatefulWidget {
  static const id = '\subCategoryScreen';

  const SubcategoryScreen({super.key});

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  SubCategoryController subCategoryController = SubCategoryController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Future<List<Category>> futureCategories;
  late String name;
  Category? selectedCategory;
  dynamic _image;

  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Sub Category",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          Divider(color: Colors.grey.shade900),

          FutureBuilder<List<Category>>(
            future: futureCategories,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text("No categories"));
              }

              return DropdownButton<Category>(
                value: selectedCategory,
                hint: const Text('Select Category'),
                items: snapshot.data!.map((Category category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                  print(selectedCategory!.name);
                },
              );
            },
          ),
          const Divider(color: Colors.grey),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: _image != null
                        ? Image.memory(_image)
                        : Text("Sub Category image"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 200,
                  child: TextFormField(
                    onChanged: (value) {
                      name = value;
                    },
                    validator: (value) {
                      if (value != null) {
                        return null;
                      } else {
                        return "Enter category name";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Enter category name",
                    ),
                  ),
                ),
              ),
              TextButton(onPressed: () {}, child: Text("Cancel")),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    subCategoryController.uploadSubCategory(
                      pickedImage: _image,
                      categoryId: selectedCategory!.id,
                      categoryName: selectedCategory!.name,
                      subCategoryName: name,
                      context: context,
                    );
                    setState(() {
                      _formKey.currentState!.reset();
                      _image = null;
                    });
                  }
                },
                child: Text("Save"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              onPressed: () {
                pickImage();
              },
              child: Text("Upload Image"),
            ),
          ),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
