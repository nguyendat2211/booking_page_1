import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../services_mobx/service_store.dart';
import 'details_service.dart';
import '../model/Items.dart';
import '../model/Services.dart';
import 'package:intl/intl.dart';

final itemStore = ServiceStore();

class OtherService extends StatefulWidget {
  late int selectedId;

  OtherService(this.selectedId, {super.key});

  @override
  OtherServiceState createState() => OtherServiceState(selectedId);
}

class OtherServiceState extends State<OtherService> {
  late ScrollController _scrollController;
  bool isLoading = false;
  final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'vnđ');
  String? formattedDiscount;
  late final Items item;

  late int selectedId;

  OtherServiceState(this.selectedId);

  void hideItem(int selectedId) {
    itemStore.itemList.forEach((item) {
      item.isVisible = item.id != selectedId;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_loadMoreItems);
    // itemStore.loadDataOther(selectedId);
    itemStore.loadData();
    print(selectedId);
    hideItem(selectedId);
  }

  Future<void> _loadMoreItems() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      itemStore.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Column(
        children: [
          Expanded(
            child: SizedBox(
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: itemStore.itemList.length,
                itemBuilder: (context, index) {
                  final items = itemStore.itemList[index];
                  final currencyFormat1 =
                      NumberFormat.currency(locale: 'vi_VN', symbol: 'vnđ');
                  String formattedPrice = currencyFormat1.format(items.price);
                  if (items.disCount != null) {
                    final discountFormat =
                        NumberFormat.currency(locale: 'vi_VN', symbol: 'vnđ');
                    formattedDiscount = discountFormat.format(items.disCount);
                  }
                  // Kiểm tra isVisible của mục trước khi hiển thị nó
                  if (!items.isVisible) {
                    return Container(); // Ẩn mục nếu isVisible là false
                  }

                  return Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    width: 390,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsService(
                                          item: itemStore.itemList[index],
                                          itemsList: itemStore.itemList,
                                        )));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey)),
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 110,
                                  height: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      items.image ?? '',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        items.name,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Arial"),
                                      ),
                                      Text(
                                        items.description ?? '',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 16, fontFamily: "Arial"),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          const Icon(
                                            CupertinoIcons.money_dollar_circle,
                                            color: Colors.blue,
                                          ),
                                          Text(
                                            formattedPrice,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(width: 15),
                                          const Icon(
                                            color: Colors.orange,
                                            Icons.discount_outlined,
                                          ),
                                          Text(
                                            formattedDiscount ?? 'N/A',
// Sử dụng 'N/A' nếu formattedDiscount là null
                                            style:
                                                const TextStyle(fontSize: 16),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    });
  }
}
