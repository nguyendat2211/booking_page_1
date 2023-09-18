import 'package:booking_page_1/booking/personally_widget.dart';
import 'package:booking_page_1/booking/relatives_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  _BookingPage createState() => _BookingPage();
}

class _BookingPage extends State<BookingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Number of tabs
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose of the TabController when not needed
    super.dispose();
  }

  void _submitForm() {
    // Thực hiện các tác vụ sau khi biểu mẫu hợp lệ
    print('Họ và tên: ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: CupertinoButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              CupertinoIcons.back,
              color: Colors.blue,
            ),
          ),
          title: const Text(
            "Thông tin lịch đặt khám",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0), // Đặt chiều cao của gạch dưới
            child: Container(
              color: Colors.blue, // Màu của gạch dưới
              height: 1.0, // Độ dài của gạch dưới
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: 850,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBar(
                    isScrollable: false,
                    controller: _tabController,
                    indicator: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    unselectedLabelColor: Colors.blue,
                    tabs: const [
                      SizedBox(
                        width: 180,
                        child: Tab(
                          child: Text('Cá nhân',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  fontFamily: 'Arial')),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: Tab(
                          child: Text('Người thân',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  fontFamily: 'Arial')),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _tabController,
                    children:const[
                      FormScreen(),
                      SecondScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
