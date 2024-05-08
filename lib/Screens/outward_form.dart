import 'dart:convert';
// import 'package:outward/Screens/add_choultries.dart';
// import 'package:outward/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OutwardForm extends StatefulWidget {
  const OutwardForm({super.key});

  @override
  State<OutwardForm> createState() => _OutwardFormState();
}

class _OutwardFormState extends State<OutwardForm> {
  List<dynamic> _data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/auth/outwards/');
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

  Future<void> submitoutward(
      String vendor_name,
      String vendor_phone,
      String description,
      String amount,
      String id,
      String httpMethod) async {
    Map data = {
      'vendor_name': vendor_name,
      'vendor_phone': vendor_phone,
      'description': description,
      'amount': amount,
      'id': id
    };

    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');

    var headerObj = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": 'Bearer $token'
    };
    final response;
    if (httpMethod == 'edit') {
      var url = Uri.parse('http://10.0.2.2:8000/api/auth/outwards/$id');
      response = await http.put(
        url,
        headers: headerObj,
        body: json.encode(data),
      );
    } else if (httpMethod == 'delete') {
      var url = Uri.parse('http://10.0.2.2:8000/api/auth/outwards/$id');
      response = await http.delete(
        url,
        headers: headerObj,
      );
    } else {
      var url = Uri.parse('http://10.0.2.2:8000/api/auth/outwards/');
      response = await http.post(
        url,
        headers: headerObj,
        body: json.encode(data),
      );
    }

    debugPrint('response11 ${response}');
    debugPrint('response code ${response.statusCode}');
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      fetchData();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Outwards.');
    }
  }

  void formoutward(Map<String, dynamic> outward) {
    // Implement editing functionality here
    // You can display a dialog similar to the one used for adding choultries
    debugPrint('outward form $outward');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String vendor_name = ("${outward['vendor_name'] ?? ""}");
        String vendor_phone = ("${outward['vendor_phone'] ?? ""}");
        String description = ("${outward['description'] ?? ""}");
        String amount = ("${outward['amount'] ?? ""}");
        String id = ("${outward['id'] ?? ""}");
        String httpMethod;
        var title;
        if (id != '') {
          httpMethod = 'edit';
          title = const Text('Edit outward');
        } else {
          httpMethod = 'add';
          title = const Text('Add outward');
        }
        return AlertDialog(
          title: title,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    vendor_name = value;
                  },
                  decoration: const InputDecoration(labelText: 'Vendor name'),
                  controller: TextEditingController(text: vendor_name),
                ),
                TextField(
                  onChanged: (value) {
                    vendor_phone = value;
                  },
                  decoration:
                      const InputDecoration(labelText: 'vendor phone'),
                  controller: TextEditingController(text: vendor_phone),
                ),
                TextField(
                  onChanged: (value) {
                    description = value;
                  },
                  decoration: const InputDecoration(labelText: 'description'),
                  controller: TextEditingController(text: description),
                ),
                TextField(
                  onChanged: (value) {
                    amount = value;
                  },
                  decoration: const InputDecoration(labelText: 'amount'),
                  controller: TextEditingController(text: amount),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Call the API to update outward with the new details
                // Assuming there is an endpoint for updating choultries
                // Navigator.pop(context);
                await submitoutward(vendor_name, vendor_phone, description,
                    amount, id, httpMethod);
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void deleteConfirmation(Map<String, dynamic> outward, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete ${outward['vendor_name']}?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                submitoutward(
                  '',
                  '',
                  '',
                  '',
                  outward['id'].toString(),
                  'delete',
                );
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade100,
        title: const Text('Outward Form'),
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
            DataColumn(label: Text('vendor_name')),
            DataColumn(label: Text('Edit\\Delete')),
          ],
          rows: _data.asMap().entries.map<DataRow>((entry) {
            final index = entry.key;
            final outward = entry.value;
            outward['httpMethod'] = 'delete';
            return DataRow(cells: [
              DataCell(Text((index + 1).toString())),
              DataCell(
                GestureDetector(
                  onTap: () {
                    // Navigate to the next page when vendor_name is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const OutwardForm(),
                      ),
                    );
                  },
                  child: Text(outward['vendor_name']),
                ),
              ),
              DataCell(Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      formoutward(outward);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteConfirmation(outward, context);
                    },
                  ),
                ],
              )),
            ]);
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open a dialog to enter outward details
          formoutward({});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
