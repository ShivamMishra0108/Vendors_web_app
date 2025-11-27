import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:ecommerce_web_app/global_variable.dart';
import 'package:ecommerce_web_app/models/subCategory.dart';
import 'package:ecommerce_web_app/services/manage_http_response.dart';
import 'package:http/http.dart' as http;


class SubCategoryController {
  uploadSubCategory({
    required dynamic pickedImage,
    required String categoryId,
    required String categoryName,
    required String subCategoryName,
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

      Subcategory subcategory = Subcategory(
        id: '',
        categoryId: categoryId,
        image: image,
        categoryName: categoryName,
        subCategoryName: subCategoryName,
      );

      http.Response response = await http.post(
        Uri.parse("$uri/api/subcategories"),
        body: subcategory.toJson(),
        headers: <String, String>{
          "Content-Type": "appplication/json; charset=UTF-8",
        },
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Sub category Uploaded");
        },
      );
    } catch (e) {
      print("$e");
    }
  }
}
