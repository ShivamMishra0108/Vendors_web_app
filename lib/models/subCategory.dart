import 'dart:convert';

class Subcategory {
  final String id;
  final String categoryId;
  final String image;
  final String categoryName;
  final String subCategoryName;

  Subcategory({
    required this.id,
    required this.categoryId,
    required this.image,
    required this.categoryName,
    required this.subCategoryName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'image': image,
      'categoryName': categoryName,
      'subCtegoryName': subCategoryName,
    };
  }

    
  factory Subcategory.fromJson(Map<String, dynamic> map) {
    return Subcategory(
      id: map['_id'] ?? '',
      categoryId: map['categoryId'] ?? '',
      image: map['image'] ?? '',
      categoryName: map['categoryName'] ?? '',
      subCategoryName: map['subCtegoryName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
}
