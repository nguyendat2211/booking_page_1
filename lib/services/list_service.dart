
import 'package:booking_page_1/services/search_for_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../services_mobx/service_store.dart';
import 'package:intl/intl.dart';

// final itemStore = ServiceStore();
class ListServices extends StatefulWidget {
  const ListServices({super.key});

  @override
  ListServicesState createState() => ListServicesState();
}

class ListServicesState extends State<ListServices> {
  int pageIndex = 0;
  late ScrollController _scrollController;
  final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'vnđ');
  String? formattedDiscount;
  final itemStore = Modular.get<ServiceStore>();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_loadMoreItems);
    itemStore.loadData();
  }

  Future<void> _loadMoreItems() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      itemStore.loadData();
    }
  }

  Future<void> _refreshData() async {
    // Đặt pageIndex về 0 để làm mới từ đầu
    itemStore.currentPage = 0;
    itemStore.itemList.clear();
    await itemStore.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Column(
          children: [
            Expanded(
                child: Scaffold(
                    appBar: AppBar(
                      leading: CupertinoButton(
                        onPressed: () {},
                        child: const Icon(
                          CupertinoIcons.back,
                          color: Colors.blue,
                        ),
                      ),
                      title: const Text(
                        "Danh sách gói dịch vụ",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(1.0),
                        child: Container(
                          color: Colors.blue,
                          height: 1.5,
                        ),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {
                            showSearch(
                              context: context,
                              delegate: MySearchDelegate(itemStore.itemList),
                            );
                          },
                          icon: const Icon(
                            Icons.search,
                            color: Colors.blueAccent,
                          ),
                        )
                      ],
                    ),
                    body: RefreshIndicator(
                      onRefresh: _refreshData,
                      child: itemStore.itemList.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : itemStore.itemList.isEmpty
                              ? const Center(child: Text('No data available.'))
                              : ListView.builder(
                                  controller: _scrollController,
                                  itemCount: itemStore.itemList.length,
                                  itemBuilder: (context, index) {
                                    final item = itemStore.itemList[index];
                                    String formattedPrice =
                                        currencyFormat.format(item.price);
                                    if (item.disCount != null) {
                                      final discountFormat =
                                          NumberFormat.currency(
                                              locale: 'vi_VN', symbol: 'vnđ');
                                      formattedDiscount =
                                          discountFormat.format(item.disCount);
                                    }

                                    return GestureDetector(
                                      onTap: () {
                                        print("Hello");
                                        Modular.to.pushNamed('/detail',
                                            arguments: item);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border:
                                                Border.all(color: Colors.grey)),
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 110,
                                              height: 100,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  item.image ?? '',
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
                                                    item.name,
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "Arial",
                                                    ),
                                                  ),
                                                  Text(
                                                    item.description ?? '',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: "Arial",
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        CupertinoIcons
                                                            .money_dollar_circle,
                                                        color: Colors.blue,
                                                      ),
                                                      Text(
                                                        formattedPrice,
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      const SizedBox(width: 15),
                                                      const Icon(
                                                        color: Colors.orange,
                                                        Icons.discount_outlined,
                                                      ),
                                                      Text(
                                                        formattedDiscount ??
                                                            'N/A',
                                                        // Sử dụng 'N/A' nếu formattedDiscount là null
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                    )))
          ],
        );
      },
    );
  }
}
