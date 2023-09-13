import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/Items.dart';
import 'other_service_widget.dart';

class DetailsService extends StatelessWidget {
  //Đây là để thử git nhánh check chứ không phải nhánh khác
  final Items item;
  List<Items> itemsList;

  //check pass 2 by Nguyen Dat oke man
  DetailsService({super.key, required this.item, required this.itemsList});

  List<Items> getSuggestions() {
    return itemsList.where((suggestion) => suggestion != item).toList();
  }

  //check it
  @override
  Widget build(BuildContext context) {
    final currencyFormat =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'vnđ');
    String formattedPrice1 = currencyFormat.format(item.price);
    int? selectedId = item.id;

    return Scaffold(
      appBar: AppBar(
        leading: CupertinoButton(
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName("/"));
          },
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.blue,
          ),
        ),
        title: const Text(
          "Chi tiết gói dịch vụ",
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
      ),
      body: Column(
        children: [
          //Ph
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                SizedBox(
                  width: 110,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      item.image ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Arial"),
                      ),
                      Text(
                        item.description ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style:
                            const TextStyle(fontSize: 16, fontFamily: "Arial"),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.money_dollar_circle,
                            color: Colors.blue,
                          ),
                          Text(
                            formattedPrice1,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 15),
                          const Icon(
                            color: Colors.orange,
                            Icons.discount_outlined,
                          ),
                          Text(' ${item.disCount} vnđ')
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          //Thanh gach ngang
          Container(
            height: 0.5,
            color: Colors.grey[400],
          ),
          SizedBox(
            height: 360,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(10),
                // Adjust the padding as needed
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Chi tiết gói",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "Lưu ý",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    "• "
                                    " Nhịn đói trước khi lấy mẫu ít nhất 6-8 tiếng, chỉ được uống nước lọc",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                      "• "
                                      " Không ăn sáng, không uống nước ngọt, nước hoa quả, sữa, rượu... để đảm bảo kết quả chính xác",
                                      style: TextStyle(fontSize: 16)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                      "• "
                                      " Với trường hợp đã chuẩn bị sẵn, trước khi siêu âm ổ bụng, bệnh nhân nên nhịn ăn ít nhất 6-8 giờ. Nên siêu âm vào buổi sáng",
                                      style: TextStyle(fontSize: 16)),
                                ),
                              ],
                            ))
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "Hướng dẫn sử dụng dịch vụ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "Xem tại đây !",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            child: Container(
              margin: const EdgeInsets.all(10),
              alignment: Alignment.bottomLeft,
              child: Column(
                children: const [
                  Text(
                    "Dịch vụ khác",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: OtherService(selectedId!)),
          Container(
            margin: const EdgeInsets.all(20), // Add margin for spacing
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Rounded border
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0), // Add padding for content
                child: Text(
                  "Đặt lịch",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
