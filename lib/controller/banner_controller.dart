import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:ecommerce_web_app/global_variable.dart';
import 'package:ecommerce_web_app/models/banner.dart';
import 'package:ecommerce_web_app/services/manage_http_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class BannerController {
  uploadBanner({required dynamic pickedImage, required context}) async {
    try {
      final cloudinary = CloudinaryPublic('dbum12hl4', "oeqnx1ce");

      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(
          pickedImage,
          identifier: "banner_image",
          folder: "banners",
        ),
      );

      String image = imageResponse.secureUrl;

      BannerModel bannerModel = BannerModel(id: "", image: image);

      http.Response response = await http.post(
        Uri.parse("$uri/api/banner"),
        body: jsonEncode(bannerModel.toJson()),
        headers: <String, String>{
          "Content-Type": "appplication/json; charset=UTF-8",
        },
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          void showSnackBar(BuildContext context, String text) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Uploaded banner")));
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<List<BannerModel>> loadBanners() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/banner'),
        headers: <String, String>{
          "Content-Type": "appplication/json; charset=UTF-8",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        List<BannerModel> banners = data
            .map((banner) => BannerModel.fromJson(banner))
            .toList();

        return banners;
      } else {
        throw Exception("Failed to load banner");
      }
    } catch (e) {
      throw Exception("Error loading banners $e");
    }
  }
}
