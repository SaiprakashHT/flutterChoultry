import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CreateChoultries extends StatefulWidget {
  const CreateChoultries({Key? key}) : super(key: key);

  @override
  State<CreateChoultries> createState() => _CreateChoultriesState();
}

class _CreateChoultriesState extends State<CreateChoultries> {
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/auth/choutries');
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

  Future<void> submitChoultry(
      String name,
      String address,
      String pin,
      String phone_number,
      String email,
      String pname,
      String id,
      String httpMethod) async {
    Map data = {
      'name': name,
      'address': address,
      'pin': pin,
      'phone_number': phone_number,
      'email': email,
      'pname': pname,
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
    if(httpMethod == 'edit'){
      var url = Uri.parse('http://10.0.2.2:8000/api/auth/choutries/$id');
       response = await http.put(
        url,
        headers: headerObj,
        body: json.encode(data),
      );
    }else if(httpMethod == 'delete'){
       var url = Uri.parse('http://10.0.2.2:8000/api/auth/choutries/$id');
      response = await http.delete(
        url,
        headers: headerObj,
      );
    }else{
      var url = Uri.parse('http://10.0.2.2:8000/api/auth/choutries/');
      response = await http.post(
        url,
        headers: headerObj,
        body: json.encode(data),
      );
    }
    
    
    debugPrint('response11 ${response.body}');
    debugPrint('response code ${response.statusCode}');
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      fetchData();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create choultry.');
    }
    
  }

  void formChoultry(Map<String, dynamic> choultry) {
    // Implement editing functionality here
    // You can display a dialog similar to the one used for adding choultries
    debugPrint('choultry form $choultry');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String choultryName = ("${choultry['name']!=null?choultry['name']:""}");
        String choultryAddress = ("${choultry['address']!=null?choultry['address']:""}");
        String choultryPin = ("${choultry['pin']!=null?choultry['pin']:""}");
        String phoneNumber = ("${choultry['phone_number']!=null?choultry['phone_number']:""}");
        String email = ("${choultry['email']!=null?choultry['email']:""}");
        String pname = ("${choultry['pname']!=null?choultry['pname']:""}");
        String id = ("${choultry['id']!=null?choultry['id']:""}");
        String httpMethod;
        var title;
        if(id != ''){
          httpMethod = 'edit';
          title =  const Text('Edit Choultry');
        }else{
          httpMethod = 'add';
          title =  const Text('Add Choultry');
        }
        return AlertDialog(
          title: title,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    choultryName = value;
                  },
                  decoration: InputDecoration(labelText: 'Choultry Name'),
                  controller: TextEditingController(text: choultryName),
                ),
                TextField(
                  onChanged: (value) {
                    choultryAddress = value;
                  },
                  decoration:
                      InputDecoration(labelText: 'Choultry Address'),
                  controller: TextEditingController(text: choultryAddress),
                ),
                TextField(
                  onChanged: (value) {
                    choultryPin = value;
                  },
                  decoration: InputDecoration(labelText: 'Choultry Pin'),
                  controller: TextEditingController(text: choultryPin),
                ),
                TextField(
                  onChanged: (value) {
                    phoneNumber = value;
                  },
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  controller: TextEditingController(text: phoneNumber),
                ),
                TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(labelText: 'Email'),
                  controller: TextEditingController(text: email),
                ),
                TextField(
                  onChanged: (value) {
                    pname = value;
                  },
                  decoration: InputDecoration(labelText: 'Pname'),
                  controller: TextEditingController(text: pname),
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
                // Call the API to update choultry with the new details
                // Assuming there is an endpoint for updating choultries
                // Navigator.pop(context);
                await submitChoultry(
                  choultryName,
                  choultryAddress,
                  choultryPin,
                  phoneNumber,
                  email,
                  pname,
                  id,
                  httpMethod
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

  void deleteChoultry(Map<String, dynamic> choultry) {
    // Implement delete functionality here
    // You can show a confirmation dialog before deleting
    String id = choultry['id'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choultries"),
      ),
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (context, index) {
          _data[index]['httpMethod'] = 'delete';
          return ListTile(
            title: Text(_data[index]['name']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    formChoultry(_data[index]);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                      submitChoultry(
                        '',
                        '',
                        '',
                        '',
                        '',
                        '',
                        _data[index]['id'].toString(),
                        'delete'
                      );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open a dialog to enter choultry details
          formChoultry({});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
