import 'dart:developer';

import 'package:tap_attend_admin/src/admin/dashboard/screens/homepage/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final _controller = Get.put(HomeController());

  // Define holidays and their colors
  final Map<DateTime, Map<String, dynamic>> holidays = {
    // DateTime(2024, 12, 25): {
    //   'name': 'Christmas Day',
    //   'color': Colors.red,
    // },
    // DateTime(2024, 11, 30): {
    //   'name': 'Bonifacio Day',
    //   'color': Colors.blue,
    // },
    // DateTime(2025, 1, 1): {
    //   'name': 'New Year\'s Day',
    //   'color': Colors.green,
    // },
  };

  @override
  void initState() {
    super.initState();
    _controller.getTotal();
    _loadHolidays();
  }

  void _addHoliday(DateTime date) {
    showDialog(
      context: context,
      builder: (context) {
        String holidayName = "";
        Color holidayColor = Colors.red;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 56, 131, 243).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.event,
                  color: Color.fromARGB(255, 56, 131, 243),
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Text(
                'Add Holiday',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Holiday Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Holiday Name',
                    hintText: 'Enter holiday name',
                    prefixIcon: Icon(
                      Icons.edit_note,
                      color: const Color.fromARGB(255, 66, 54, 54),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 56, 131, 243),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  onChanged: (value) {
                    holidayName = value;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Select Color',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Holiday Color',
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      ),
                      DropdownButton<Color>(
                        value: holidayColor,
                        items: [
                          DropdownMenuItem(
                            value: Colors.red,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.3),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: Colors.blue,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withOpacity(0.3),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          DropdownMenuItem(
                            value: Colors.green,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.green.withOpacity(0.3),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              holidayColor = value;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // ignore: deprecated_member_use
                final colorValue = holidayColor.value;
                await _controller.addHolidayToFirebase(
                  date: date,
                  name: holidayName,
                  color: colorValue,
                );
                await _loadHolidays();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 56, 131, 243),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                'Add Holiday',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _loadHolidays() async {
    Map<String, Map<String, dynamic>> loadedHolidays =
        await _controller.getHolidaysFromFirebase();
    setState(() {
      holidays.clear();
      loadedHolidays.forEach((key, value) {
        if (value['date'] != null &&
            value['name'] != null &&
            value['color'] != null) {
          holidays[value['date'] as DateTime] = {
            'id': key,
            'name': value['name'] as String,
            'color': value['color'] as Color,
          };
        }
      });
    });
  }

  void _deleteHoliday(String docId, DateTime date) async {
    await _controller.deleteHolidayFromFirebase(docId);
    await _loadHolidays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              const SizedBox(height: 5),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(
                  () => Row(
                    children: [
                      _buildCards(
                        'Teachers',
                        '${_controller.totalTeacher}',
                        'Track current number of teachers',
                        const Color.fromARGB(255, 189, 249, 192)
                        // ignore: deprecated_member_use
                        .withOpacity(.2),
                        const FaIcon(FontAwesomeIcons.userGroup),
                      ),
                      _buildCards(
                        'Sections',
                        '${_controller.totalSection}',
                        'Track current number of sections',
                        // ignore: deprecated_member_use
                        Colors.red.withOpacity(0.05),
                        // ignore: deprecated_member_use
                        const FaIcon(FontAwesomeIcons.gripHorizontal),
                      ),
                      _buildCards(
                        'Subjects',
                        '${_controller.totalSubject}',
                        'Track current number of subjects',
                        // ignore: deprecated_member_use
                        Colors.blue.withOpacity(.05),
                        const FaIcon(FontAwesomeIcons.bookOpen),
                      ),
                      _buildCards(
                        'Students',
                        '${_controller.totalStudent}',
                        'Track current number of students',
                        // ignore: deprecated_member_use
                        Colors.grey.withOpacity(.05),
                        const FaIcon(FontAwesomeIcons.graduationCap),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(maxHeight: 450),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 15,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(
                                        255,
                                        56,
                                        131,
                                        243,
                                      ).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Icons.calendar_month,
                                      color: Color.fromARGB(255, 56, 131, 243),
                                      size: 22,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'Academic Calendar',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                ),
                                child: Text(
                                  DateFormat('MMMM yyyy').format(_focusedDay),
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Expanded(
                            child: SingleChildScrollView(
                              child: TableCalendar(
                                focusedDay: _focusedDay,
                                firstDay: DateTime(2000),
                                lastDay: DateTime(2100),
                                selectedDayPredicate:
                                    (day) => isSameDay(_selectedDay, day),
                                calendarFormat: _calendarFormat,
                                onDaySelected: (selectedDay, focusedDay) {
                                  setState(() {
                                    _selectedDay = selectedDay;
                                    _focusedDay = focusedDay;
                                  });
                                },
                                holidayPredicate:
                                    (day) => holidays.keys.any(
                                      (holiday) => isSameDay(day, holiday),
                                    ),
                                calendarStyle: CalendarStyle(
                                  outsideDaysVisible: false,
                                  weekendTextStyle: TextStyle(
                                    color: Colors.red[300],
                                    fontWeight: FontWeight.w500,
                                  ),
                                  holidayTextStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  defaultTextStyle: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  todayDecoration: BoxDecoration(
                                    color: Color.fromARGB(
                                      255,
                                      56,
                                      131,
                                      243,
                                    ).withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  selectedDecoration: BoxDecoration(
                                    color: Color.fromARGB(255, 56, 131, 243),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromARGB(
                                          255,
                                          56,
                                          131,
                                          243,
                                        ).withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  holidayDecoration: BoxDecoration(
                                    color: Colors.green[400],
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.green[400]!.withOpacity(
                                          0.3,
                                        ),
                                        blurRadius: 8,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  markerDecoration: BoxDecoration(
                                    color: Color.fromARGB(255, 56, 131, 243),
                                    shape: BoxShape.circle,
                                  ),
                                  cellMargin: EdgeInsets.all(4),
                                  cellPadding: EdgeInsets.all(4),
                                ),
                                headerStyle: HeaderStyle(
                                  formatButtonVisible: false,
                                  titleCentered: true,
                                  titleTextStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                    letterSpacing: 0.3,
                                  ),
                                  leftChevronIcon: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[50],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.chevron_left,
                                      color: Color.fromARGB(255, 56, 131, 243),
                                      size: 20,
                                    ),
                                  ),
                                  rightChevronIcon: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[50],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.chevron_right,
                                      color: Color.fromARGB(255, 56, 131, 243),
                                      size: 20,
                                    ),
                                  ),
                                  headerPadding: EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                ),
                                calendarBuilders: CalendarBuilders(
                                  markerBuilder: (context, date, events) {
                                    if (events.isNotEmpty) {
                                      return Positioned(
                                        bottom: 1,
                                        child: Container(
                                          width: 5,
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                              255,
                                              56,
                                              131,
                                              243,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      );
                                    }
                                    return null;
                                  },
                                ),
                                eventLoader:
                                    (day) =>
                                        holidays.containsKey(day)
                                            ? [holidays[day]!['name']]
                                            : [],
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Center(
                            child: ElevatedButton.icon(
                              onPressed:
                                  _selectedDay == null
                                      ? null
                                      : () => _addHoliday(_selectedDay!),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(
                                  255,
                                  56,
                                  131,
                                  243,
                                ),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                                disabledBackgroundColor: Colors.grey[300],
                                disabledForegroundColor: Colors.grey[600],
                              ),
                              icon: Icon(Icons.add, size: 18),
                              label: Text(
                                'Add Holiday',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: double.infinity,
                      constraints: BoxConstraints(maxHeight: 400),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHolidayHeader(),
                          Expanded(child: _buildHolidayList()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCards(
    String title,
    String total,
    String label,
    Color colors,
    FaIcon icon,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(20),
      ),
      width: 280,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              icon,
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              total,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 5),
          Align(alignment: Alignment.topLeft, child: Text(label)),
        ],
      ),
    );
  }

  Widget _buildHolidayHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 56, 131, 243).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.calendar_today,
                  color: Color.fromARGB(255, 56, 131, 243),
                  size: 20,
                ),
              ),
              SizedBox(width: 12),
              Text(
                'Upcoming Holidays',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          Text(
            '${holidays.length} Events',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildHolidayList() {
    if (holidays.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy, size: 48, color: Colors.grey[400]),
            SizedBox(height: 16),
            Text(
              'No upcoming holidays',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: holidays.length,
      itemBuilder: (context, index) {
        final entry = holidays.entries.toList()[index];
        final date = entry.key;
        final details = entry.value;

        return Container(
          margin: EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (details['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.event,
                color: details['color'] as Color,
                size: 20,
              ),
            ),
            title: Text(
              details['name'] as String,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            subtitle: Text(
              DateFormat('MMMM d, yyyy').format(date),
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete_outline, color: Colors.red[400]),
              onPressed: () {
                _showDeleteConfirmation(details['id'] as String, date);
              },
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(String id, DateTime date) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.orange[400]),
                SizedBox(width: 8),
                Text('Delete Holiday'),
              ],
            ),
            content: Text('Are you sure you want to delete this holiday?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _deleteHoliday(id, date);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Delete'),
              ),
            ],
          ),
    );
  }
}
