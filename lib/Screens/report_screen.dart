import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<dynamic> _data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/auth/bokings/');
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');

    var headerObj = {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $token'
    };
    final response = await http.get(url, headers: headerObj);
    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body);
      debugPrint('responsedata: $responseData');
      List<Map<String, dynamic>> dataList = [];
      for (var entry in responseData) {
        if (entry is Map<String, dynamic>) {
          dataList.add(entry);
        }
      }
      setState(() {
        _data = dataList;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: const Text('Report'),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.add), // Add your custom icon here
      //       onPressed: () {
      //         // Add functionality for saving form data here
      //         print('Form data saved');
      //       },
      //     ),
      //   ],
       ),
      body: SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Sl.no')),
            DataColumn(label: Text('Name')),
            // DataColumn(label: Text('Actions')),
          ],
          rows: _data.asMap().entries.map<DataRow>((entry) {
            final index = entry.key;
            final booking = entry.value;
            // booking['httpMethod'] = 'delete';
            return DataRow(cells: [
              DataCell(Text((index + 1).toString())),
              DataCell(
                GestureDetector(
                  onTap: () {
                    // Navigate to the next page when name is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ReportScreen(),
                      ),
                    );
                  },
                  child: Text(booking['customer_name']),
                ),
              ),
              // DataCell(Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     IconButton(
              //       icon: Icon(Icons.edit),
              //       onPressed: () {
              //         (booking);
              //       },
              //     ),
              //     IconButton(
              //       icon: Icon(Icons.delete),
              //       onPressed: () {
              //         (booking, context);
              //       },
              //     ),
              //   ],
              // )),
            ]);
          }).toList(),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Open a dialog to enter booking details
      //     ({});
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }

}