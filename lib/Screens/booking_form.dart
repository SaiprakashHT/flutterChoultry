import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:choultry/Screens/booking_items.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({Key? key});

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
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

  Future<void> submitbooking(
      String customerName,
      String customerAddress,
      String customerPincode,
      String customerPhone,
      String customerGstNo,
      String startDate,
      String endDate,
      String advance,
      String total,
      List<Map<String, dynamic>> bookingItems,
      String id,
      String httpMethod) async {
    Map data = {
      'customer_name': customerName,
      'customer_address': customerAddress,
      'customer_pincode': customerPincode,
      'customer_phone': customerPhone,
      'customer_gst_no': customerGstNo,
      'start_date': startDate,
      'end_date': endDate,
      'advance': advance,
      'total': total,
      'booking_items': bookingItems,
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
      var url = Uri.parse('http://10.0.2.2:8000/api/auth/bokings/$id');
      response = await http.put(
        url,
        headers: headerObj,
        body: json.encode(data),
      );
    } else if (httpMethod == 'delete') {
      var url = Uri.parse('http://10.0.2.2:8000/api/auth/bokings/$id');
      response = await http.delete(
        url,
        headers: headerObj,
      );
    } else {
      var url = Uri.parse('http://10.0.2.2:8000/api/auth/bokings/');
      response = await http.post(
        url,
        headers: headerObj,
        body: json.encode(data),
      );
    }

    debugPrint('response11 ${response}');
    debugPrint('response code ${response.statusCode}');
    if (response.statusCode == 200) {
      fetchData();
    } else {
      throw Exception('Failed to create booking.');
    }
  }

  void formbooking(Map<String, dynamic> booking) {
    debugPrint('booking form $booking');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String customerName = ("${booking['customer_name'] ?? ""}");
        String customerAddress = ("${booking['customer_address'] ?? ""}");
        String customerPincode = ("${booking['customer_pincode'] ?? ""}");
        String customerPhone = ("${booking['customer_phone'] ?? ""}");
        String customerGstNo = ("${booking['customer_gst_no'] ?? ""}");
        String startDate = ("${booking['start_date'] ?? ""}");
        String endDate = ("${booking['end_date'] ?? ""}");
        String advance = ("${booking['advance'] ?? ""}");
        String total = ("${booking['total'] ?? ""}");
        String id = ("${booking['id'] ?? ""}");
        String httpMethod;
        var title;
        if (id != '') {
          httpMethod = 'edit';
          title = const Text('Edit booking');
        } else {
          httpMethod = 'add';
          title = const Text('Add booking');
        }
        return AlertDialog(
          title: title,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    customerName = value;
                  },
                  decoration: const InputDecoration(labelText: 'Customer Name'),
                  controller: TextEditingController(text: customerName),
                ),
                TextField(
                  onChanged: (value) {
                    customerAddress = value;
                  },
                  decoration:
                      const InputDecoration(labelText: 'Customer Address'),
                  controller: TextEditingController(text: customerAddress),
                ),
                TextField(
                  onChanged: (value) {
                    customerPincode = value;
                  },
                  decoration: const InputDecoration(labelText: 'Customer Pincode'),
                  controller: TextEditingController(text: customerPincode),
                ),
                TextField(
                  onChanged: (value) {
                    customerPhone = value;
                  },
                  decoration: const InputDecoration(labelText: 'Customer Phone'),
                  controller: TextEditingController(text: customerPhone),
                ),
                TextField(
                  onChanged: (value) {
                    customerGstNo = value;
                  },
                  decoration: const InputDecoration(labelText: 'Customer GST No'),
                  controller: TextEditingController(text: customerGstNo),
                ),
                TextField(
                  onChanged: (value) {
                    startDate = value;
                  },
                  decoration: const InputDecoration(labelText: 'Start Date'),
                  controller: TextEditingController(text: startDate),
                ),
                TextField(
                  onChanged: (value) {
                    endDate = value;
                  },
                  decoration: const InputDecoration(labelText: 'End Date'),
                  controller: TextEditingController(text: endDate),
                ),
                TextField(
                  onChanged: (value) {
                    advance = value;
                  },
                  decoration: const InputDecoration(labelText: 'Advance'),
                  controller: TextEditingController(text: advance),
                ),
                TextField(
                  onChanged: (value) {
                    total = value;
                  },
                  decoration: const InputDecoration(labelText: 'Total'),
                  controller: TextEditingController(text: total),
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
                await submitbooking(
                  customerName,
                  customerAddress,
                  customerPincode,
                  customerPhone,
                  customerGstNo,
                  startDate,
                  endDate,
                  advance,
                  total,                  
                  [], // Pass empty booking items list for now
                  id,
                  httpMethod,
                );
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void deleteConfirmation(Map<String, dynamic> booking, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete ${booking['customer_name']}?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                submitbooking(
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  [],
                  booking['id'].toString(),
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
        title: const Text('Booking Form'),
      ),
      body: SingleChildScrollView(
        child: DataTable(
          columnSpacing: 10.0,
          columns: const [
            DataColumn(label: Text('Sl.no')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Edit\\Delete')),
          ],
          rows: _data.asMap().entries.map<DataRow>((entry) {
            final index = entry.key;
            final booking = entry.value;
            booking['httpMethod'] = 'delete';
            return DataRow(cells: [
              DataCell(Text((index + 1).toString())),
              DataCell(
                GestureDetector(
                  onTap: () {
                    formbooking(booking);
                  },
                  child: Text(booking['customer_name']),
                ),
              ),
              DataCell(Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      formbooking(booking);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteConfirmation(booking, context);
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
          Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const BookingItems(),
                    ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
