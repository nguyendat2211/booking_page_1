import 'package:mobx/mobx.dart';

class Items {
  int? id;
  int? price;
  int? originalPrice;
  String? image;
  String? icon;
  String? categoryId;
  String? categoryName;
  String? description;
  late String name;
  String? code;
  bool? insurance;
  String? gender;
  String? categoryGroupCode;
  int? disCount;
  bool? isGetSample;
  bool? isSeeDoctor;
  bool? isChoiceDoctor;
  int? status;
  bool? testAtHome;
  bool? examAtHome;
  int? numberOrder;

  Items(
      {this.id,
      this.price,
      this.originalPrice,
      this.image,
      this.icon,
      this.categoryId,
      this.categoryName,
      this.description,
      required this.name,
      this.code,
      this.insurance,
      this.gender,
      this.categoryGroupCode,
      this.disCount,
      this.isGetSample,
      this.isSeeDoctor,
      this.isChoiceDoctor,
      this.status,
      this.testAtHome,
      this.examAtHome,
      this.numberOrder});

  bool isVisible = true; // Thêm thuộc tính isVisible mặc định là true

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    originalPrice = json['originalPrice'];
    image = json['image'];
    icon = json['icon'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    description = json['description'];
    name = json['name'];
    code = json['code'];
    insurance = json['insurance'];
    gender = json['gender'];
    categoryGroupCode = json['categoryGroupCode'];
    disCount = json['disCount'];
    isGetSample = json['isGetSample'];
    isSeeDoctor = json['isSeeDoctor'];
    isChoiceDoctor = json['isChoiceDoctor'];
    status = json['status'];
    testAtHome = json['testAtHome'];
    examAtHome = json['examAtHome'];
    numberOrder = json['numberOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['originalPrice'] = this.originalPrice;
    data['image'] = this.image;
    data['icon'] = this.icon;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['description'] = this.description;
    data['name'] = this.name;
    data['code'] = this.code;
    data['insurance'] = this.insurance;
    data['gender'] = this.gender;
    data['categoryGroupCode'] = this.categoryGroupCode;
    data['disCount'] = this.disCount;
    data['isGetSample'] = this.isGetSample;
    data['isSeeDoctor'] = this.isSeeDoctor;
    data['isChoiceDoctor'] = this.isChoiceDoctor;
    data['status'] = this.status;
    data['testAtHome'] = this.testAtHome;
    data['examAtHome'] = this.examAtHome;
    data['numberOrder'] = this.numberOrder;
    return data;
  }
}
