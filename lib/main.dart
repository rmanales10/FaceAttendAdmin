import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tap_attend_admin/src/admin/dashboard/dashboard.dart';
import 'package:tap_attend_admin/src/admin/dashboard/screens/activity_log/activity_log.dart';
import 'package:tap_attend_admin/src/admin/dashboard/screens/homepage/home_page.dart';
import 'package:tap_attend_admin/src/admin/dashboard/screens/students/student_page.dart';
import 'package:tap_attend_admin/src/admin/dashboard/screens/subjects/subject_page.dart';
import 'package:tap_attend_admin/src/admin/dashboard/screens/teachers/teacher_page.dart';
import 'package:tap_attend_admin/src/admin/main_screen/admin.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class Admin extends StatelessWidget {
  const Admin({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tap Attend',
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreenForAdmin()),
        GetPage(name: '/activity-log', page: () => ActivityLogPage()),
        GetPage(name: '/subject', page: () => SubjectPage()),
        GetPage(name: '/student', page: () => StudentPage()),
        GetPage(name: '/teacher', page: () => TeacherPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/dashboard', page: () => AdminDashboard()),
      ],
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Admin());
}
