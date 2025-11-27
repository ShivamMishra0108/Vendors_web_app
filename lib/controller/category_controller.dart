import 'dart:convert';
import 'dart:ui_web';
import 'package:flutter/material.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:ecommerce_web_app/global_variable.dart';
import 'package:ecommerce_web_app/models/category.dart';
import 'package:ecommerce_web_app/services/manage_http_response.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  uploadCategory({
    required dynamic pickedImage,
    required dynamic pickedBanner,
    required String name,
    required context,
  }) async {
    try {
      final cloudinary = CloudinaryPublic('dbum12hl4', "oeqnx1ce");

      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromByteData(
          pickedImage,
          identifier: 'pickedImage',
          folder: 'categoryImage',
        ),
      );
      String image = imageResponse.secureUrl;

      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromByteData(
          pickedBanner,
          identifier: 'pickedBanner',
          folder: 'categoryImage',
        ),
      );

      String banner = bannerResponse.secureUrl;

      Category category = Category(
        id: "",
        name: name,
        image: image,
        banner: banner,
      );

      http.Response response = await http.post(
        Uri.parse("$uri/api/categories"),
        body: category.toJson(),
        headers: <String, String>{
          "Content-Type": "appplication/json; charset=UTF-8",
        },
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Uploaded Category");
        },
      );
    } catch (e) {
      print("Error uploading to cloudinary $e");
    }
  }

  Future<List<Category>> loadCategories() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/categories'),
        headers: <String, String>{
          "Content-Type": "appplication/json; charset=UTF-8",
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        List<Category> categories = data
            .map((category) => Category.fromJson(category))
            .toList();

        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error loading categories $e');
    }
  }
}
