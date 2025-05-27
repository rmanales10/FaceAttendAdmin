import 'package:tap_attend_admin/src/admin/dashboard/screens/activity_log/activity_log.dart';
import 'package:tap_attend_admin/src/admin/dashboard/screens/homepage/home_page.dart';
import 'package:tap_attend_admin/src/admin/dashboard/screens/students/student_page.dart';
import 'package:tap_attend_admin/src/admin/dashboard/screens/subjects/subject_page.dart';

import 'package:tap_attend_admin/src/admin/dashboard/screens/teachers/teacher_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  // Track the current page
  String currentPage = 'Dashboard';

  void setPage(String page) {
    setState(() {
      currentPage = page;
    });
  }

  Widget getContent() {
    switch (currentPage) {
      case 'Dashboard':
        return HomePage();
      case 'Teachers':
        return TeacherPage();
      case 'Students':
        return StudentPage();
      // case 'Sections':
      //   return SectionPage();
      case 'Subjects':
        return SubjectPage();
      case 'Activity Logs':
        return ActivityLogPage();
      default:
        return Center(child: Text('Main Content Area'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(currentPage: currentPage, onPageSelected: setPage),
          Expanded(child: getContent()),
        ],
      ),
    );
  }
}

class Sidebar extends StatelessWidget {
  final String currentPage;
  final Function(String) onPageSelected;

  const Sidebar({
    super.key,
    required this.currentPage,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Material(
      elevation: 4,
      color: Color(0xFF1E1E2C),
      child: SizedBox(
        width: 280,
        height: screenHeight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30),
              // Logo and Title
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image(
                        image: AssetImage('assets/logo.png'),
                        width: 40,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Face Attend',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),

              // Menu Items
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildMenuItem(
                      Icons.dashboard_outlined,
                      'Dashboard',
                      isSelected: currentPage == 'Dashboard',
                      onTap: () => onPageSelected('Dashboard'),
                    ),
                    _buildMenuItem(
                      Icons.people_outline,
                      'Teachers',
                      isSelected: currentPage == 'Teachers',
                      onTap: () => onPageSelected('Teachers'),
                    ),
                    _buildMenuItem(
                      Icons.school_outlined,
                      "Students",
                      isSelected: currentPage == 'Students',
                      onTap: () => onPageSelected('Students'),
                    ),
                    _buildMenuItem(
                      Icons.book_outlined,
                      'Subjects',
                      isSelected: currentPage == 'Subjects',
                      onTap: () => onPageSelected('Subjects'),
                    ),
                    _buildMenuItem(
                      Icons.history_outlined,
                      'Activity Logs',
                      isSelected: currentPage == 'Activity Logs',
                      onTap: () => onPageSelected('Activity Logs'),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Bottom Section
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(Icons.logout_rounded, color: Colors.red[300]),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.red[300],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () => Get.offAllNamed('/login'),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title, {
    bool isSelected = false,
    required Function() onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.blue : Colors.grey[400],
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey[300],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 15,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: onTap,
        hoverColor: Colors.blue.withOpacity(0.05),
        selectedTileColor: Colors.blue.withOpacity(0.1),
        selected: isSelected,
      ),
    );
  }
}
