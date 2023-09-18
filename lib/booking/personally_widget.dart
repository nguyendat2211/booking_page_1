import 'package:flutter/material.dart';
import 'calendar_widget.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PersonallyPage();
  }
}

class PersonallyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BookingForMe();
}

class BookingForMe extends State<PersonallyPage> {
  TextEditingController textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String fullName = '';
  String birthday = '';
  String phoneNumber = '';
  String cmnd = '';
  String bhyt = '';
  String selectedGender = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
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
                  keyboardType: TextInputType.number,
                ),

                //Số thẻ BHYT
                const SizedBox(height: 15),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Số thẻ BHYT ',
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
                ),
                SizedBox(height: 10),
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
        Expanded(child: CalendarBooking()),
        Container(
          margin: const EdgeInsets.only(bottom: 30),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0), // Rounded border
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Đặt lịch",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
