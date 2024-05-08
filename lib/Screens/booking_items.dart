import 'dart:convert';
import 'package:choultry/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BookingItems extends StatefulWidget {
  const BookingItems({Key? key});

  @override
  State<BookingItems> createState() => _BookingItemsItemsState();
}

class _BookingItemsItemsState extends State<BookingItems> {
  String? selectedInventoryId;
  List<String> inventoryList = [];
  // List<dynamic> _data = [];

  @override
  void initState() {
    super.initState();
    fetchInventoryList(); // Fetch inventory list when the widget initializes
  }

  DropdownButton<String> buildInventoryDropdown() {
    return DropdownButton<String>(
      dropdownColor: Colors.red.shade100,
      isExpanded: true,
      value: selectedInventoryId,
      icon: Icon(Icons.arrow_circle_down_rounded),
      onChanged: (String? newValue) {
        setState(() {
          selectedInventoryId = newValue;
        });
      },
      items: inventoryList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value, // Use the item from the inventoryList as the value
          child: Text(value),
        );
      }).toList(),
    );
  }

  void formbookingitems(Map<String, dynamic> booking_items) {
    // Implement editing functionality here
    // You can display a dialog similar to the one used for adding choultries
    debugPrint('formbooking form $booking_items');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String inventory_id = ("${booking_items['inventory_id'] ?? ""}");
        String price = ("${booking_items['price'] ?? ""}");
        String quantity = ("${booking_items['quantity'] ?? ""}");
        String total = ("${booking_items['total'] ?? ""}");
        String id = ("${booking_items['id'] ?? ""}");
        String httpMethod;
        var title;
        if (id != '') {
          httpMethod = 'edit';
          title = const Text('Edit bookingItems');
        } else {
          httpMethod = 'add';
          title = const Text('Add bookingItems');
        }

        return AlertDialog(
          title: title,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                // Replace the TextField with the DropdownButton
                Container(
                  margin: EdgeInsets.all(10),
                  height: 70,
                  //color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton<String>(
                    dropdownColor: Colors.grey.shade100,
                    isExpanded: true,
                    value: selectedInventoryId,
                    icon: Icon(Icons.arrow_circle_down_rounded),
                    onChanged: (String? newvalue) {
                      setState(() {
                        selectedInventoryId = newvalue!;
                      });
                    },
                    items: inventoryList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value:
                            value, // Use the item from the inventoryList as the value
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    price = value;
                  },
                  decoration: const InputDecoration(labelText: 'Price'),
                  controller: TextEditingController(text: price),
                ),
                TextField(
                  onChanged: (value) {
                    quantity = value;
                  },
                  decoration: const InputDecoration(labelText: 'quantity'),
                  controller: TextEditingController(text: quantity),
                ),
                TextField(
                  onChanged: (value) {
                    total = value;
                  },
                  decoration: const InputDecoration(labelText: 'total'),
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
                // Call the API to update inventory with the new details
                // Assuming there is an endpoint for updating choultries
                // Navigator.pop(context);
                // await submitInventory(inventory_id, price, quantity,
                //     total, id, httpMethod);
                // Navigator.pop(context);
              },
              child: const Text('Update'),
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
        title: const Text('booking Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Customer Name',
                ),
                onChanged: (value) {
                  // _name = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Customer Address',
                ),
                onChanged: (value) {
                  // _name = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Customer Pincode',
                ),
                onChanged: (value) {
                  // _name = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Phone Number',
                ),
                onChanged: (value) {
                  // _phone = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Gst No',
                ),
                onChanged: (value) {
                  // _email = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Start Date',
                ),
                onChanged: (value) {
                  // _password = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'End Date',
                ),
                onChanged: (value) {
                  // _c_password = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Advance',
                ),
                onChanged: (value) {
                  // _c_password = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Total',
                ),
                onChanged: (value) {
                  // _c_password = value;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              RoundedButton(
                btnText: 'Save',
                onBtnPressed: () => '',
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open a dialog to enter bill details
          formbookingitems({});
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> fetchInventoryList() async {
  String apiUrl = 'http://10.0.2.2:8000/api/auth/booking_items';

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);

      // Extract inventory items from the response
      List<String> inventoryNames = [];
      for (var item in data) {
        String itemName = item['name']; // Assuming 'name' is the field containing the inventory item name
        inventoryNames.add(itemName);
      }

      // Update the state with the inventory items
      setState(() {
        inventoryList = inventoryNames;
      });
    } else {
      throw Exception(
          'Failed to load inventory items: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching inventory list: $e');
    // Handle the error appropriately
  }
}


}
