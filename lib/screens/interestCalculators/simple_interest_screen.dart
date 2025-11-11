import 'package:flutter/material.dart';
import '../../database/db_helper.dart';
import '../../models/interest_calculation.dart';
import '../history/history_page.dart';

class SimpleInterestScreen extends StatefulWidget {
  const SimpleInterestScreen({super.key});

  @override
  State<SimpleInterestScreen> createState() => _SimpleInterestScreenState();
}

class _SimpleInterestScreenState extends State<SimpleInterestScreen> {
  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  double? _simpleInterest;
  double? _totalAmount;

  @override
  void initState() {
    super.initState();
    _principalController.addListener(_onTextChanged);
    _rateController.addListener(_onTextChanged);
    _timeController.addListener(_onTextChanged);
  }

  void _onTextChanged() async {
    final principalText = _principalController.text;
    final rateText = _rateController.text;
    final timeText = _timeController.text;

    if (principalText.isNotEmpty &&
        rateText.isNotEmpty &&
        timeText.isNotEmpty) {
      final principal = double.tryParse(principalText);
      final rate = double.tryParse(rateText);
      final time = double.tryParse(timeText);

      if (principal != null && rate != null && time != null) {
        final si = (principal * rate * time) / 100;
        final amount = principal + si;

        setState(() {
          _simpleInterest = si;
          _totalAmount = amount;
        });

        await DBHelper.instance.insertData(
          InterestData.fromMap({
            'principal': principal,
            'rate': rate,
            'time': time,
            'result': si,
            'amount': amount,
            "type": "SI"
          }),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(

      backgroundColor: colorScheme.surface,//colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Remove the background color
        elevation: 0, // Remove the shadow
        centerTitle: true,
        title: Text(
          "Simple Interest",
          style: textTheme.titleLarge?.copyWith(
            color: Colors.white, // Set the title color to white
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: Colors.white), // Set icon color to white
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HistoryPage()),
              );
            },
          )
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Card
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 5,
              color: colorScheme.background,//colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: [
                    _buildTextField(
                      controller: _principalController,
                      label: "Principal Amount",
                      hint: "Enter principal in ₹",
                      icon: Icons.account_balance_wallet_rounded,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _rateController,
                      label: "Rate of Interest",
                      hint: "Enter rate (%)",
                      icon: Icons.percent_rounded,
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _timeController,
                      label: "Time Period",
                      hint: "Enter time in years",
                      icon: Icons.schedule_rounded,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // // Result Card
            // if (_simpleInterest != null)
            //   Container(
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20),
            //       color: colorScheme.secondary,
            //       boxShadow: const [
            //         BoxShadow(
            //           color: Colors.black26,
            //           blurRadius: 8,
            //           offset: Offset(0, 4),
            //         )
            //       ],
            //     ),
            //     padding: const EdgeInsets.all(24),
            //     child: Column(
            //       children: [
            //         Text(
            //           "Simple Interest",
            //           style: TextStyle(
            //             color: colorScheme.onSecondary,
            //             fontSize: 16,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //         const SizedBox(height: 8),
            //         Text(
            //           "₹${_simpleInterest!.toStringAsFixed(2)}",
            //           style: const TextStyle(
            //             color: Colors.white,
            //             fontSize: 28,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         const SizedBox(height: 24),
            //         Text(
            //           "Total Amount",
            //           style: TextStyle(
            //             color: colorScheme.onSecondary.withOpacity(0.9),
            //             fontSize: 16,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //         const SizedBox(height: 8),
            //         Text(
            //           "₹${_totalAmount!.toStringAsFixed(2)}",
            //           style: const TextStyle(
            //             color: Colors.white,
            //             fontSize: 28,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ],
            //     ),
            //   )
            // else
            //   Center(
            //     child: Column(
            //       children: const [
            //         Icon(Icons.show_chart_rounded, size: 80, color: Colors.grey),
            //         SizedBox(height: 16),
            //         Text(
            //           "Enter values to calculate",
            //           style: TextStyle(
            //             color: Colors.grey,
            //             fontSize: 16,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),


            // Result Card
            // Result Card
            if (_simpleInterest != null)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF1ABC9C), // Teal Green background for result card
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(
                      "Simple Interest",
                      style: TextStyle(
                        color: const Color(0xFFE0E0E0), // Light Gray text
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "₹${_simpleInterest!.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Color(0xFFE0E0E0), // Light Gray for the result
                        fontSize: 28,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      "Total Amount",
                      style: TextStyle(
                        color: const Color(0xFFE0E0E0), // Light Gray for the label
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "₹${_totalAmount!.toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Color(0xFFE0E0E0), // Light Gray for the result
                        fontSize: 28,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
              )
            else
              Center(
                child: Column(
                  children: const [
                    Icon(Icons.show_chart_rounded, size: 80, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      "Enter values to calculate",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: colorScheme.primary),
        filled: true,
        fillColor: colorScheme.background,//colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        labelStyle: TextStyle(color: colorScheme.onSurface),
        hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
      ),
    );
  }
}

//
// class SimpleInterestScreen extends StatefulWidget {
//   const SimpleInterestScreen({super.key});
//
//   @override
//   State<SimpleInterestScreen> createState() => _SimpleInterestScreenState();
// }
//
// class _SimpleInterestScreenState extends State<SimpleInterestScreen> {
//   final TextEditingController _principalController = TextEditingController();
//   final TextEditingController _rateController = TextEditingController();
//   final TextEditingController _timeController = TextEditingController();
//
//   double? _simpleInterest;
//   double? _totalAmount;
//
//   @override
//   void initState() {
//     super.initState();
//     _principalController.addListener(_onTextChanged);
//     _rateController.addListener(_onTextChanged);
//     _timeController.addListener(_onTextChanged);
//   }
//
//   void _onTextChanged() async {
//     final principalText = _principalController.text;
//     final rateText = _rateController.text;
//     final timeText = _timeController.text;
//
//     if (principalText.isNotEmpty &&
//         rateText.isNotEmpty &&
//         timeText.isNotEmpty) {
//       final principal = double.tryParse(principalText);
//       final rate = double.tryParse(rateText);
//       final time = double.tryParse(timeText);
//
//       if (principal != null && rate != null && time != null) {
//         final si = (principal * rate * time) / 100;
//         final amount = principal + si;
//
//         setState(() {
//           _simpleInterest = si;
//           _totalAmount = amount;
//         });
//
//         await DBHelper.instance.insertData(
//           InterestData.fromMap({
//             'principal': principal,
//             'rate': rate,
//             'time': time,
//             'result': si,
//             'amount': amount,
//             "type": "SI"
//           }),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final textTheme = Theme.of(context).textTheme;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Simple Interest"),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.history),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => HistoryPage()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Input Card
//             Card(
//               color: Colors.black87.withOpacity(00.1), // Lighter shade of black for the input card
//               elevation: 8,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//                 child: Column(
//                   children: [
//                     _buildTextField(
//                       controller: _principalController,
//                       label: "Principal Amount",
//                       hint: "Enter principal in ₹",
//                       icon: Icons.account_balance_wallet_rounded,
//                     ),
//                     const SizedBox(height: 20),
//                     _buildTextField(
//                       controller: _rateController,
//                       label: "Rate of Interest",
//                       hint: "Enter rate (%)",
//                       icon: Icons.percent_rounded,
//                     ),
//                     const SizedBox(height: 20),
//                     _buildTextField(
//                       controller: _timeController,
//                       label: "Time Period",
//                       hint: "Enter time in years",
//                       icon: Icons.schedule_rounded,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 24),
//
//             // Result Card
//             if (_simpleInterest != null)
//               Container(
//                 decoration: BoxDecoration(
//                   color: colorScheme.secondary,
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 8,
//                       offset: Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   children: [
//                     Text(
//                       "Simple Interest",
//                       style: TextStyle(
//                         color: colorScheme.onSecondary.withOpacity(0.7),
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       "₹${_simpleInterest!.toStringAsFixed(2)}",
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 24),
//                     Text(
//                       "Total Amount",
//                       style: TextStyle(
//                         color: colorScheme.onSecondary.withOpacity(0.7),
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       "₹${_totalAmount!.toStringAsFixed(2)}",
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             else
//               Center(
//                 child: Column(
//                   children: const [
//                     Icon(Icons.show_chart_rounded, size: 80, color: Colors.grey),
//                     SizedBox(height: 16),
//                     Text(
//                       "Enter values to calculate",
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required String hint,
//     required IconData icon,
//   }) {
//     return TextField(
//       controller: controller,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(
//         labelText: label,
//         hintText: hint,
//         prefixIcon: Icon(icon),
//         filled: true,
//         fillColor: Colors.black, // Black background for fields
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide.none,
//         ),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//         labelStyle: const TextStyle(color: Colors.white), // White label text
//         hintStyle: const TextStyle(color: Colors.white70), // Light gray hint text
//       ),
//     );
//   }
// }
