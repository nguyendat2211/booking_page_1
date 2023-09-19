// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'calendar_widget.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const RelativesPage();
  }
}

class RelativesPage extends StatefulWidget {
  const RelativesPage({super.key});

  @override
  State<StatefulWidget> createState() => RelativesState();
}

class RelativesState extends State<RelativesPage> {
  TextEditingController textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String fullName = '';
  String birthday = '';
  String phoneNumber = '';
  String id_card = '';
  String heatlthInsurance = '';
  String selectedGender = '';
  bool isGenderSelected = false;
  bool heightOut = false;

  // Hàm validate Booking
  bool validateBooking() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        height: heightOut ? 800 : 830,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //HỌ VÀ TÊN
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Họ và tên *',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 3,
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Họ và tên không được để trống';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        fullName = value!;
                      },
                    ),
                    // NGÀY SINH
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: textController,
                      decoration: InputDecoration(
                        labelText: 'Ngày sinh *',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 3,
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            ).then((pickedDate) {
                              if (pickedDate != null) {
                                // Trích xuất ngày, tháng và năm từ pickedDate
                                String formattedDate =
                                    "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                // Cập nhật giá trị của TextFormField
                                textController.text = formattedDate;
                              }
                            });
                          },
                          icon: const Icon(Icons.calendar_month_outlined),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ngày sinh không được để trống';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        birthday = value!;
                      },
                    ),
                    // GIỚI TÍNH
                    const SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Radio(
                                value: 'Nam',
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value as String;
                                    isGenderSelected =
                                        true; // Đã chọn giới tính
                                  });
                                },
                              ),
                              const Text('Nam'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Radio(
                                value: 'Nữ',
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value as String;
                                    isGenderSelected =
                                        true; // Đã chọn giới tính
                                  });
                                },
                              ),
                              const Text('Nữ'),
                              const SizedBox(width: 20),
                              Text(selectedGender.toString())
                            ],
                          ),
                        ],
                      ),
                    ),
                    //SỐ ĐIỆN THOẠI
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Số điện thoại *',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 3,
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Số điện thoại không được để trống';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        phoneNumber = value!;
                      },
                    ),
                    // SỐ CCCD
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'CCCD/CMND ',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 3,
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onSaved: (value) {
                        id_card = value!;
                      },
                      keyboardType: TextInputType.number,
                    ),

                    //Số thẻ BHYT
                    const SizedBox(height: 15),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Số thẻ BHYT',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 3,
                            color: Colors.blue,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onSaved: (value) {
                        heatlthInsurance = value!;
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Lịch khám:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(child: CalendarBooking()),
            Flexible(
              child: ElevatedButton(
                onPressed: () {
                  if (validateBooking()) {
                    // Nếu tất cả các trường dữ liệu đã được nhập đúng
                    _formKey.currentState!.save();
                    print('Họ và tên: $fullName');
                    print('Ngày sinh: $birthday');
                    print('Số điện thoại: $phoneNumber');
                    print('CCCD/CMND:$id_card');
                    print('Số thẻ BHYT:$heatlthInsurance');
                    print('Giới tính: $selectedGender');

                    // Sau đó, bạn có thể thực hiện các xử lý khác, ví dụ: gửi dữ liệu lên máy chủ
                  } else if (isGenderSelected) {
                    // Người dùng đã chọn giới tính
                    print('Giới tính đã được chọn: $selectedGender');
                  } else {
                    // Người dùng chưa chọn giới tính
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Vui lòng chọn giới tính.'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0), // Rounded border
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Tiếp tục",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
