import 'dart:convert';
// import 'package:bill/Screens/add_choultries.dart';
// import 'package:bill/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BillingForm extends StatefulWidget {
  const BillingForm({super.key});

  @override
  State<BillingForm> createState() => _BillingFormState();
}

class _BillingFormState extends State<BillingForm> {
  List<dynamic> _data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/auth/bills/');
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

  Future<void> submitBill(
      String booking_id,
      String customer_name,
      String customer_phone,
      String customer_address,
      String customer_gst,
      String bill_no,
      String paid,
      String paid_date_time,
      String id,
      String httpMethod) async {
    Map data = {
      'booking_id': booking_id,
      'customer_name': customer_name,
      'customer_phone': customer_phone,
      'customer_address': customer_address,
      'customer_gst': customer_gst,
      'bill_no': bill_no,
      'paid': paid,
      'paid_date_time': paid_date_time,
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
      var url = Uri.parse('http://10.0.2.2:8000/api/auth/bills/$id');
      response = await http.put(
        url,
        headers: headerObj,
        body: json.encode(data),
      );
    } else if (httpMethod == 'delete') {
      var url = Uri.parse('http://10.0.2.2:8000/api/auth/bills/$id');
      response = await http.delete(
        url,
        headers: headerObj,
      );
    } else {
      var url = Uri.parse('http://10.0.2.2:8000/api/auth/bills/');
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
      throw Exception('Failed to create bill.');
    }
  }

  void formBill(Map<String, dynamic> bill) {
    // Implement editing functionality here
    // You can display a dialog similar to the one used for adding choultries
    debugPrint('bill form $bill');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String booking_id = ("${bill['booking_id'] ?? ""}");
        String customer_name = ("${bill['customer_name'] ?? ""}");
        String customer_phone = ("${bill['customer_phone'] ?? ""}");
        String customer_address = ("${bill['customer_address'] ?? ""}");
        String customer_gst = ("${bill['customer_gst'] ?? ""}");
        String bill_no = ("${bill['bill_no'] ?? ""}");
        String paid = ("${bill['paid'] ?? ""}");
        String paid_date_time = ("${bill['paid_date_time'] ?? ""}");
        String id = ("${bill['id'] ?? ""}");
        String httpMethod;
        var title;
        if (id != '') {
          httpMethod = 'edit';
          title = const Text('Edit bill');
        } else {
          httpMethod = 'add';
          title = const Text('Add bill');
        }
        return AlertDialog(
          title: title,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    booking_id = value;
                  },
                  decoration: const InputDecoration(labelText: 'booking_id'),
                  controller: TextEditingController(text: booking_id),
                ),
                TextField(
                  onChanged: (value) {
                    customer_name = value;
                  },
                  decoration: const InputDecoration(labelText: 'customer_name'),
                  controller: TextEditingController(text: customer_name),
                ),
                TextField(
                  onChanged: (value) {
                    customer_phone = value;
                  },
                  decoration:
                      const InputDecoration(labelText: 'customer_phone'),
                  controller: TextEditingController(text: customer_phone),
                ),
                TextField(
                  onChanged: (value) {
                    customer_address = value;
                  },
                  decoration:
                      const InputDecoration(labelText: 'customer_address'),
                  controller: TextEditingController(text: customer_address),
                ),
                TextField(
                  onChanged: (value) {
                    customer_gst = value;
                  },
                  decoration: const InputDecoration(labelText: 'customer_gst'),
                  controller: TextEditingController(text: customer_gst),
                ),
                TextField(
                  onChanged: (value) {
                    bill_no = value;
                  },
                  decoration: const InputDecoration(labelText: 'bill_no'),
                  controller: TextEditingController(text: bill_no),
                ),
                TextField(
                  onChanged: (value) {
                    paid = value;
                  },
                  decoration: const InputDecoration(labelText: 'paid'),
                  controller: TextEditingController(text: paid),
                ),
                TextField(
                  onChanged: (value) {
                    paid_date_time = value;
                  },
                  decoration:
                      const InputDecoration(labelText: 'paid_date_time'),
                  controller: TextEditingController(text: paid_date_time),
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
                // Call the API to update bill with the new details
                // Assuming there is an endpoint for updating choultries
                // Navigator.pop(context);
                await submitBill(
                    booking_id,
                    customer_name,
                    customer_phone,
                    customer_address,
                    customer_gst,
                    bill_no,
                    paid,
                    paid_date_time,
                    id,
                    httpMethod);
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void deleteConfirmation(Map<String, dynamic> bill, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content:
              Text("Are you sure you want to delete ${bill['customer_name']}?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                submitBill(
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  bill['id'].toString(),
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
        title: const Text('Billing Form'),
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
            DataColumn(label: Text('Actions')),
          ],
          rows: _data.asMap().entries.map<DataRow>((entry) {
            final index = entry.key;
            final bill = entry.value;
            bill['httpMethod'] = 'delete';
            return DataRow(cells: [
              DataCell(Text((index + 1).toString())),
              DataCell(
                GestureDetector(
                  onTap: () {
                    // Navigate to the next page when customer_name is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BillingForm(),
                      ),
                    );
                  },
                  child: Text(bill['customer_name']),
                ),
              ),
              DataCell(Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      formBill(bill);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteConfirmation(bill, context);
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
          // Open a dialog to enter bill details
          formBill({});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
