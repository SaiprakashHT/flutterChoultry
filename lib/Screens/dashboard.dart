import 'package:choultry/Screens/add_choultries.dart';
import 'package:choultry/Screens/billing_form.dart';
import 'package:choultry/Screens/booking_form.dart';
import 'package:choultry/Screens/inventory_form.dart';
import 'package:choultry/Screens/outward_form.dart';
import 'package:choultry/Screens/report_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade700,
        title: const Text('Srinivas Choultry'),
        toolbarHeight: 70,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle,
                size: 50), // Increase size to 36
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CreateChoultries(),
                ),
              );
              // Add your functionality to navigate to the profile screen here
              print('Profile tapped');
            },
          ),
        ],
      ),
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InventoryForm(),
                        ),
                      );
                      // Add your functionality for Today Booking here
                      print('Inventory');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(), // Add border around the section
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:
                            CrossAxisAlignment.center, // Align text center
                        children: [
                          Text(
                            'Inventory',
                            textAlign: TextAlign.center, // Align text center
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 40),
                          // Add today's booking content here
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookingForm(),
                        ),
                      );
                      // Add your functionality for Today Booking here
                      print('Booking');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(), // Add border around the section
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Booking',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 40),
                          // Add today's booking content here
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BillingForm(),
                        ),
                      );
                      // Add your functionality for This Month Booking here
                      print('Billing');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(), // Add border around the section
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Billing',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 40),
                          // Add this month's booking content here
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OutwardForm(),
                        ),
                      );
                      // Add your functionality for This Month Booking here
                      print('Outward');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(), // Add border around the section
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Outward',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 40),
                          // Add this month's booking content here
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReportScreen(),
                        ),
                      );
                      // Add your functionality for Today Booking here
                      print('Report');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(), // Add border around the section
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(left: 8, right: 205),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Report',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            width: 40,
                          ),
                          // Add today's booking content here
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 3),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(), // Add border to each menu item
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: DashboardScreen(),
  ));
}
