import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/Items.dart';
import 'details_service.dart';

class MySearchDelegate extends SearchDelegate {
  final List<Items> serviceList;
  final int maxList;

  MySearchDelegate(this.serviceList, {this.maxList = 18});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      CupertinoButton(
        onPressed: () {
          query = "";
        },
        child: const Icon(
          CupertinoIcons.clear_circled,
          color: Colors.black,
        ),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        close(context, "");
      },
      child: const Icon(
        CupertinoIcons.back,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Items> suggestionList = serviceList
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (suggestionList.isEmpty) {
      // No results found, display a message
      return const Center(
        child: Text(
          'Không tìm thấy dịch vụ',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    final limitedSuggestions =
        suggestionList.take(maxList).toList(); // Limit suggestions

    return SingleChildScrollView(
      child: Column(
        children: [
          // Header
          const ListTile(
            title: Text(
              'Dịch vụ gợi ý',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Suggestions
          ListView.builder(
            shrinkWrap: true,
            itemCount: limitedSuggestions.length,
            itemBuilder: (context, index) {
              final Items product = limitedSuggestions[index];

              return Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.grey)),
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      product.image ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    product.name,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            CupertinoIcons.money_dollar_circle,
                            color: Colors.blue,
                          ),
                          Text(
                            '  ${product.price} vnđ',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(width: 15),
                          const Icon(
                            color: Colors.orange,
                            Icons.discount_outlined,
                          ),
                          Text(' ${product.disCount} vnđ')
                        ],
                      )),
                  contentPadding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsService(
                                item: limitedSuggestions[index])));
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
