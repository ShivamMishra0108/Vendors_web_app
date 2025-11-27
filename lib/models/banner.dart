import 'dart:convert';

class BannerModel {
  final String id;
  final String image;

  BannerModel({required this.id, required this.image});

  Map<String, dynamic> toMap() {
    return {'id': id, 'image': image};
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(id: map['_id'] ?? '', image: map['image'] ?? '');
  }



  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
