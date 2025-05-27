import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'activity_log_controller.dart';

class ActivityLogPage extends StatefulWidget {
  const ActivityLogPage({super.key});

  @override
  State<ActivityLogPage> createState() => _ActivityLogPageState();
}

class _ActivityLogPageState extends State<ActivityLogPage> {
  final ActivityLogController controller = Get.put(ActivityLogController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1024;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? screenWidth * 0.05 : screenWidth * 0.025,
          vertical: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(12),
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
                          Icons.history,
                          size: 32,
                          color: Color.fromARGB(255, 56, 131, 243),
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Activity Log',
                            style: TextStyle(
                              fontSize: isDesktop ? 32 : 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Monitor user activities and system events',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: TextField(
                      onChanged: (value) {
                        controller.setSearchQuery(value);
                      },
                      decoration: InputDecoration(
                        hintText: "Search by email...",
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Summary Cards
            Obx(() {
              controller.fetchActivityLogs();
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24),
                child: Flex(
                  direction: isDesktop ? Axis.horizontal : Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSummaryCard(
                      title: "Total Users",
                      count: controller.totalUsers,
                      color: Color.fromARGB(255, 56, 131, 243).withOpacity(0.1),
                      icon: Icons.people_outline,
                      onTap: () => controller.setFilterType("All"),
                    ),
                    _buildSummaryCard(
                      title: "Online Users",
                      count: controller.onlineUsers,
                      color: Colors.green.withOpacity(0.1),
                      icon: Icons.circle,
                      onTap: () => controller.setFilterType("Online"),
                    ),
                    _buildSummaryCard(
                      title: "Offline Users",
                      count: controller.offlineUsers,
                      color: Colors.red.withOpacity(0.1),
                      icon: Icons.circle_outlined,
                      onTap: () => controller.setFilterType("Offline"),
                    ),
                  ],
                ),
              );
            }),
            SizedBox(height: 24),

            // Data Table
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Obx(() {
                  controller.fetchActivityLogs();
                  final filteredData = controller.filteredData;

                  if (filteredData.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.history,
                            size: 48,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No activity logs found',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              headingRowColor: WidgetStateProperty.all(
                                Color.fromARGB(
                                  255,
                                  56,
                                  131,
                                  243,
                                ).withOpacity(0.1),
                              ),
                              columnSpacing:
                                  isDesktop ? 80 : screenWidth * 0.05,
                              columns: [
                                _buildDataColumn("Email", isDesktop),
                                _buildDataColumn("IP Address", isDesktop),
                                _buildDataColumn("Date", isDesktop),
                                _buildDataColumn("Time", isDesktop),
                                _buildDataColumn("Action", isDesktop),
                                _buildDataColumn("Description", isDesktop),
                              ],
                              rows:
                                  filteredData.map((row) {
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Text(
                                            row['email'],
                                            style: _cellTextStyle(),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            row['ip'],
                                            style: _cellTextStyle(),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            row['date'],
                                            style: _cellTextStyle(),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            row['time'],
                                            style: _cellTextStyle(),
                                          ),
                                        ),
                                        DataCell(
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  row['action'] == "Online"
                                                      ? Colors.green
                                                          .withOpacity(0.1)
                                                      : Colors.red.withOpacity(
                                                        0.1,
                                                      ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                color:
                                                    row['action'] == "Online"
                                                        ? Colors.green
                                                            .withOpacity(0.3)
                                                        : Colors.red
                                                            .withOpacity(0.3),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  row['action'] == "Online"
                                                      ? Icons.circle
                                                      : Icons.circle_outlined,
                                                  size: 12,
                                                  color:
                                                      row['action'] == "Online"
                                                          ? Colors.green
                                                          : Colors.red,
                                                ),
                                                SizedBox(width: 6),
                                                Text(
                                                  row['action'],
                                                  style: TextStyle(
                                                    color:
                                                        row['action'] ==
                                                                "Online"
                                                            ? Colors.green
                                                            : Colors.red,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            row['description'],
                                            style: _cellTextStyle(),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required int count,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.5), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: color.withOpacity(0.8), size: 24),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "$count",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DataColumn _buildDataColumn(String label, bool isDesktop) {
    return DataColumn(
      label: Text(
        label,
        style: TextStyle(
          fontSize: isDesktop ? 16 : 14,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  TextStyle _cellTextStyle() {
    return TextStyle(color: Colors.black87, fontSize: 14);
  }
}
