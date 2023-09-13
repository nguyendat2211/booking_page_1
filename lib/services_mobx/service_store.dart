import 'dart:convert';


import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;

import '../model/Items.dart';
import '../model/Services.dart';

part 'service_store.g.dart';

class ServiceStore = _ServiceStore with _$ServiceStore;

abstract class _ServiceStore with Store {
  @observable
  ObservableList<Items> itemList = ObservableList();

  @observable
  bool isLoading = false;

  @observable
  int currentPage = 0;

  late List<Items> items;

  // late int selectedID;

  @action
  Future<void> loadData() async {
    try {
      isLoading = true;
      final uri = Uri.parse(
          "http://116.97.240.210:5105/api/packages/?pageSize=10&pageIndex=$currentPage&MedicalUnitId=1");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final Services services = Services.fromJson(jsonData);
        final List<Items> newItems = services.data!.items ?? [];
        itemList.addAll(newItems);
        if (newItems.isNotEmpty) {
          currentPage++;
        }
        isLoading = false;
      } else {
        throw Exception("Failed to load service");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> loadDataOther(int selectedID) async {
    try {
      isLoading = true;
      final uri = Uri.parse(
          "http://116.97.240.210:5105/api/packages/?pageSize=10&pageIndex=$currentPage&MedicalUnitId=1");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final Services services = Services.fromJson(jsonData);
        final List<Items> newItems = services.data!.items ?? [];
        items.addAll(newItems);

        items = items.where((item) => item.id != selectedID).toList();
        if (newItems.isNotEmpty) {
          currentPage++;
        }
        isLoading = false;
      } else {
        throw Exception("Failed to load service");
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading = false;
    }
  }
}
