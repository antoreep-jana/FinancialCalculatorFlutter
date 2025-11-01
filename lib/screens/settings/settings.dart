import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  // A list of currencies with their symbols
  final List<Map<String, String>> _currencies = [
    {'name': 'US Dollar (USD)', 'symbol': '\$', 'code': 'USD'},
    {'name': 'Euro (EUR)', 'symbol': '€', 'code': 'EUR'},
    {'name': 'British Pound (GBP)', 'symbol': '£', 'code': 'GBP'},
    {'name': 'Indian Rupee (INR)', 'symbol': '₹', 'code': 'INR'},
    {'name': 'Japanese Yen (JPY)', 'symbol': '¥', 'code': 'JPY'},
  ];

  // The selected currency's index
  String _selectedCurrency = "₹";//'INR';  // Default is INR

  @override
  void initState(){
    super.initState();
    _loadCurrency();
  }

  void _loadCurrency() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedCurrency = prefs.getString('currencySymbol') ?? "₹";
    });
  }

  // Save the selected currency
  void _saveCurrency(String currency) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("currencySymbol", currency);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.person, color: Colors.blue),
              title: const Text("Edit Profile"),
              subtitle: const Text("Change your profile details"),
              onTap: () {
                // Navigate to the edit profile page or show a dialog
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.notifications, color: Colors.blue),
              title: const Text("Notifications"),
              subtitle: const Text("Manage notification preferences"),
              onTap: () {
                // Navigate to notifications settings
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.blue),
              title: const Text("Privacy Settings"),
              subtitle: const Text("Manage your privacy settings"),
              onTap: () {
                // Navigate to privacy settings
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.language, color: Colors.blue),
              title: const Text("Language"),
              subtitle: const Text("Change your language preference"),
              onTap: () {
                // Navigate to language settings
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: const Text("Logout"),
              subtitle: const Text("Sign out of your account"),
              onTap: () {
                // Handle logout logic
              },
            ),

            const Divider(),

            // Currency Settings Section
            // ListTile(
            //   leading: const Icon(Icons.monetization_on, color: Colors.green),
            //   title: const Text("Currency"),
            //   subtitle: Text("Select your preferred currency"),
            //   trailing: DropdownButton<String>(
            //     value: _selectedCurrency,
            //     onChanged: (String? newValue) {
            //       setState(() {
            //         _selectedCurrency = newValue!;
            //         _saveCurrency(_selectedCurrency); // Save to shared preferences
            //       });
            //     },
            //     items: _currencies
            //       .map<DropdownMenuItem<String>>((Map<String,String> currency) {
            //         return DropdownMenuItem<String>(
            //           value: currency['symbol'],//currency['code'],
            //           child: Text(
            //             "${currency['name']} (${currency['symbol']})",
            //             style: const TextStyle(fontSize : 14),
            //           )
            //         );
            //     }).toList()
            //   ),
            // ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(Icons.monetization_on, color: Colors.green),
                  title: const Text("Currency"),
                  subtitle: Text("Select your preferred currency"),
                ),
                // Dropdown centered as a new item in the Column
                Align(
                  alignment: Alignment.center,  // Center the dropdown horizontally
                  child: DropdownButton<String>(
                    value: _selectedCurrency,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCurrency = newValue!;
                        _saveCurrency(_selectedCurrency); // Save to shared preferences
                      });
                    },
                    isExpanded: false,  // Do not expand to fill width, keeping it compact
                    items: _currencies.map<DropdownMenuItem<String>>((Map<String, String> currency) {
                      return DropdownMenuItem<String>(
                        value: currency['symbol'], // currency['code'],
                        child: Text(
                          "${currency['name']} (${currency['symbol']})",
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.center, // Center text inside the item
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            )



          ],
        ),
      ),
    );
  }
}