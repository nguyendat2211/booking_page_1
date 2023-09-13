import 'Items.dart';

class Data {
  int? pageIndex;
  int? pageSize;
  int? total;
  List<Items>? items;
  int? countOfPage;

  Data(
      {this.pageIndex,
      this.pageSize,
      this.total,
      this.items,
      this.countOfPage});

  Data.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    total = json['total'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    countOfPage = json['countOfPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    data['total'] = total;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['countOfPage'] = this.countOfPage;
    return data;
  }
}
