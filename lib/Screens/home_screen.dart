import 'dart:convert';
import 'package:choultry/Screens/add_choultries.dart';
import 'package:choultry/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<dynamic> _data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  addChoultry() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => CreateChoultries(),
        ));
  }

  Future<void> fetchData() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/auth/choutries/');
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'access_token');

    var headerObj = {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $token'
    };
    final response = await http.get(url, headers: headerObj);
    var dataJson = jsonDecode(response.body);
    debugPrint('toke1n $dataJson');
    // final response = await http.get();
    if (response.statusCode == 200) {
      setState(() {
        _data = jsonDecode(response.body);
        debugPrint('responsebodydata: $_data');
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        toolbarHeight: 70,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Choultries",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        // child: Container(
        child: Center(
          child: ListTile(
            // padding: const EdgeInsets.all(20),
            title: Stack(
              children: [
                // Content area
                Column(
                  children: [
                    // DataTable
                    DataTable(
                      columns: const [
                        DataColumn(
                            label:
                                Text('Sl.no', style: TextStyle(fontSize: 20))),
                        DataColumn(
                            label:
                                Text('Name', style: TextStyle(fontSize: 20))),
                      ],
                      rows: _data.isNotEmpty
                          ? _data.map((entry) {
                              return DataRow(cells: [
                                DataCell(
                                  Text(
                                    (_data.indexOf(entry) + 1).toString(),
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                                DataCell(
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              CreateChoultries(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      entry['name'],
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ]);
                            }).toList()
                          : [
                              const DataRow(cells: [
                                DataCell(Text("Choultries",
                                    style: TextStyle(fontSize: 20))),
                                // DataCell(Text("Choultries", style: TextStyle(fontSize: 20))),
                              ]),
                            ],
                    ),
                  ],
                ),
                // Button row at the bottom (if data is not empty)
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: MediaQuery.of(context)
                        .size
                        .width, // Set the width to the screen width
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RoundedButton(
                          btnText: 'Add Choultry',
                          onBtnPressed: () => addChoultry(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}
