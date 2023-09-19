import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MaterialApp(home: CalendarBooking()));

class CalendarBooking extends StatefulWidget {
  const CalendarBooking({super.key});

  @override
  State<StatefulWidget> createState() => CalendarState();
}

class CalendarState extends State<CalendarBooking> {
  List<String> daysOfWeek = [];
  List<String> datesOfMonth = [];
  List<String> timesOfDay = [];
  int selectedDay = -1;
  int selectedHour = -1;
  String? selectedDate;
  String? selectedTime;

  @override
  void initState() {
    super.initState();
    initializeDates();
    initializeTimes();
  }

  void initializeDates() {
    final currentDate = DateTime.now();
    final DateFormat dateFormat = DateFormat('EEEE', 'vi_VN');
    final DateFormat monthDateFormat = DateFormat('dd/MM', 'vi_VN');
    final currentMonth = currentDate.month;

    for (int i = 0; i < 30; i++) {
      final day = currentDate.add(Duration(days: i));
      final formattedDayOfWeek = dateFormat.format(day);
      final formattedDateOfMonth = monthDateFormat.format(day);

      if (formattedDayOfWeek != 'Chủ Nhật' && day.month == currentMonth) {
        daysOfWeek.add(formattedDayOfWeek);
        datesOfMonth.add(formattedDateOfMonth);
      }
    }
  }

  void initializeTimes() {
    final startTime = TimeOfDay(hour: 7, minute: 0);
    final endTime = TimeOfDay(hour: 17, minute: 30);

    var currentTime = startTime;
    while (currentTime.hour < endTime.hour ||
        (currentTime.hour == endTime.hour &&
            currentTime.minute <= endTime.minute)) {
      final formattedTime = DateFormat('hh:mm a')
          .format(DateTime(0, 1, 1, currentTime.hour, currentTime.minute));
      timesOfDay.add(formattedTime);

      // Tăng thời gian thêm 30 phút
      currentTime = currentTime.replacing(
        hour: currentTime.hour + (currentTime.minute + 30 >= 60 ? 1 : 0),
        minute: (currentTime.minute + 30) % 60,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Thiết lập vuốt ngang
                itemCount: daysOfWeek.length,
                itemBuilder: (BuildContext context, int index) {
                  final isSelected = selectedDay == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        // Kiểm tra xem có ngày nào được chọn trước đó không
                        selectedDay = isSelected ? -1 : index;
                        if (!isSelected) {
                          // Lấy ngày tháng đã chọn khi người dùng chọn
                          selectedDate = datesOfMonth[index];
                        } else {
                          selectedDate =
                              null; // Bỏ chọn ngày tháng nếu người dùng bỏ chọn
                        } // Đảo trạng thái chọn
                        print(selectedDate.toString());
                      });
                    },
                    child: Container(
                      width: 120,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Đặt bán kính bo tròn
                        ),
                        color: isSelected ? Colors.blue : Colors.white,
                        elevation: 5.0,
                        margin: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              daysOfWeek[index],
                              style: TextStyle(
                                fontSize: 16.0,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
                              datesOfMonth[index],
                              style: TextStyle(
                                fontSize: 16.0,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: timesOfDay.length,
                itemBuilder: (BuildContext context, int index) {
                  final time = timesOfDay[index];
                  final isSelected = selectedTime == time;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedTime =
                              null; // Bỏ chọn nếu đã được chọn trước đó
                        } else {
                          selectedTime =
                              time; // Chọn nếu chưa được chọn trước đó
                        }
                        print(selectedTime); // In ra giá trị đã chọn hoặc null
                      });
                    },
                    child: Container(
                      width: 120,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: isSelected ? Colors.blue : Colors.white,
                        elevation: 5.0,
                        margin: const EdgeInsets.all(5.0),
                        child: Center(
                          child: Text(
                            time,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
