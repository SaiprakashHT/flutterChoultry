import 'dart:convert';
// import 'package:inventory/Screens/add_choultries.dart';
// import 'package:inventory/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class InventoryForm extends StatefulWidget {
  const InventoryForm({super.key});

  @override
  State<InventoryForm> createState() => _InventoryFormState();
}

class _InventoryFormState extends State<InventoryForm> {
  List<dynamic> _data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/auth/inventories/');
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

  Future<void> submitInventory(
      String name,
      String price,
      String stock,
      String igst,
      String sgst,
      String cgst,
      String user_id,
      String id,
      String httpMethod) async {
    Map data = {
      'name': name,
      'price': price,
      'stock': stock,
      'igst': igst,
      'sgst': sgst,
      'cgst': cgst,
      'user_id': user_id,
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
      var url = Uri.parse('http://10.0.2.2:8000/api/auth/inventories/$id');
      response = await http.put(
        url,
        headers: headerObj,
        body: json.encode(data),
      );
    } else if (httpMethod == 'delete') {
      var url = Uri.parse('http://10.0.2.2:8000/api/auth/inventories/$id');
      response = await http.delete(
        url,
        headers: headerObj,
      );
    } else {
      var url = Uri.parse('http://10.0.2.2:8000/api/auth/inventories/');
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
      throw Exception('Failed to create Inventory.');
    }
  }

  void formInventory(Map<String, dynamic> inventory) {
    // Implement editing functionality here
    // You can display a dialog similar to the one used for adding choultries
    debugPrint('inventory form $inventory');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String name = ("${inventory['name'] ?? ""}");
        String price = ("${inventory['price'] ?? ""}");
        String stock = ("${inventory['stock'] ?? ""}");
        String igst = ("${inventory['igst'] ?? ""}");
        String sgst = ("${inventory['sgst'] ?? ""}");
        String cgst = ("${inventory['cgst'] ?? ""}");
        String user_id = ("${inventory['user_id'] ?? ""}");
        String id = ("${inventory['id'] ?? ""}");
        String httpMethod;
        var title;
        if (id != '') {
          httpMethod = 'edit';
          title = const Text('Edit Inventory');
        } else {
          httpMethod = 'add';
          title = const Text('Add Inventory');
        }
        return AlertDialog(
          title: title,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    name = value;
                  },
                  decoration: const InputDecoration(labelText: 'Inventory Name'),
                  controller: TextEditingController(text: name),
                ),
                TextField(
                  onChanged: (value) {
                    price = value;
                  },
                  decoration:
                      const InputDecoration(labelText: 'Price'),
                  controller: TextEditingController(text: price),
                ),
                TextField(
                  onChanged: (value) {
                    stock = value;
                  },
                  decoration: const InputDecoration(labelText: 'Stock'),
                  controller: TextEditingController(text: stock),
                ),
                TextField(
                  onChanged: (value) {
                    igst = value;
                  },
                  decoration: const InputDecoration(labelText: 'Igst'),
                  controller: TextEditingController(text: igst),
                ),
                TextField(
                  onChanged: (value) {
                    sgst = value;
                  },
                  decoration: const InputDecoration(labelText: 'Sgst'),
                  controller: TextEditingController(text: sgst),
                ),
                TextField(
                  onChanged: (value) {
                    cgst = value;
                  },
                  decoration: const InputDecoration(labelText: 'Cgst'),
                  controller: TextEditingController(text: cgst),
                ),
                TextField(
                  onChanged: (value) {
                    user_id = value;
                  },
                  decoration: const InputDecoration(labelText: 'user_id'),
                  controller: TextEditingController(text: user_id),
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
                // Call the API to update inventory with the new details
                // Assuming there is an endpoint for updating choultries
                // Navigator.pop(context);
                await submitInventory(name, price, stock,
                    igst, sgst, cgst, user_id, id, httpMethod);
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void deleteConfirmation(Map<String, dynamic> inventory, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete ${inventory['name']}?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                submitInventory(
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  '',
                  inventory['id'].toString(),
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
        title: const Text('Inventory Form'),
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
            final inventory = entry.value;
            inventory['httpMethod'] = 'delete';
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
                            const InventoryForm(),
                      ),
                    );
                  },
                  child: Text(inventory['name']),
                ),
              ),
              DataCell(Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      formInventory(inventory);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteConfirmation(inventory, context);
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
          // Open a dialog to enter inventory details
          formInventory({});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
