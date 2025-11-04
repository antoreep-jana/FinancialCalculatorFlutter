// import 'package:flutter/material.dart';
//
//
// class FDCalculatorPage extends StatefulWidget {
//   @override
//   _FDCalculatorPageState createState() => _FDCalculatorPageState();
// }
//
// class _FDCalculatorPageState extends State<FDCalculatorPage> {
//   // Input variables
//   double principal = 100000; // default 1 lakh
//   double roi = 6.5; // default 6.5%
//   int years = 1;
//   int months = 0;
//   String interestPayout = 'Maturity';
//   double tdsRate = 10.0; // Default TDS rate %
//
//   // Output variables
//   double interestPaid = 0.0;
//   double effectiveInterestPaid = 0.0;
//   double effectiveRate = 0.0;
//
//   List<String> payoutOptions = ['Maturity', 'Quarterly', 'Monthly', 'Half-Yearly'];
//
//
//   void calculateFD() {
//     double tenureInYears = years + months / 12;
//
//     double n = 1; // compounding frequency
//     int payoutFrequency = 1; // number of payouts
//     if (interestPayout == 'Monthly') {
//       n = 12;
//       payoutFrequency = (years * 12 + months);
//     } else if (interestPayout == 'Quarterly') {
//       n = 4;
//       payoutFrequency = ((years * 12 + months) / 3).ceil();
//     } else if (interestPayout == 'Half-Yearly') {
//       n = 2;
//       payoutFrequency = ((years * 12 + months) / 6).ceil();
//     } else if (interestPayout == 'Maturity') {
//       n = 1;
//       payoutFrequency = 1;
//     }
//
//     // Compound Interest formula
//     double amount = principal * pow((1 + roi / 100 / n), n * tenureInYears);
//     double interest = amount - principal;
//
//     // TDS deduction
//     double tds = interest * (tdsRate / 100);
//     double netInterest = interest - tds;
//
//     // Effective ROI
//     double effectiveROI = (netInterest / principal) / tenureInYears * 100;
//
//     // Interest per payout
//     double interestPerPayout = interest / payoutFrequency;
//     double netInterestPerPayout = netInterest / payoutFrequency;
//
//     setState(() {
//       interestPaid = interest;
//       effectiveInterestPaid = netInterest;
//       effectiveRate = effectiveROI;
//       _interestPerPayout = interestPerPayout;
//       _netInterestPerPayout = netInterestPerPayout;
//       _payoutFrequencyCount = payoutFrequency;
//     });
//   }
//
// // Add these new state variables:
//   double _interestPerPayout = 0.0;
//   double _netInterestPerPayout = 0.0;
//   int _payoutFrequencyCount = 1;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('FD Calculator'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Principal Amount', style: TextStyle(fontWeight: FontWeight.bold)),
//             SizedBox(height: 8),
//             TextField(
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 prefixText: '₹ ',
//               ),
//               onChanged: (value) {
//                 principal = double.tryParse(value) ?? principal;
//               },
//               controller: TextEditingController(text: principal.toStringAsFixed(0)),
//             ),
//             SizedBox(height: 16),
//             Text('Rate of Interest (%)', style: TextStyle(fontWeight: FontWeight.bold)),
//             Slider(
//               value: roi,
//               min: 1,
//               max: 15,
//               divisions: 140,
//               label: roi.toStringAsFixed(2),
//               onChanged: (value) {
//                 setState(() {
//                   roi = value;
//                 });
//               },
//             ),
//             SizedBox(height: 16),
//             Text('Tenure', style: TextStyle(fontWeight: FontWeight.bold)),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Years',
//                     ),
//                     onChanged: (value) {
//                       years = int.tryParse(value) ?? years;
//                     },
//                     controller: TextEditingController(text: years.toString()),
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: TextField(
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Months',
//                     ),
//                     onChanged: (value) {
//                       months = int.tryParse(value) ?? months;
//                     },
//                     controller: TextEditingController(text: months.toString()),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),
//             Text('Interest Payout', style: TextStyle(fontWeight: FontWeight.bold)),
//             DropdownButtonFormField<String>(
//               value: interestPayout,
//               items: payoutOptions.map((option) {
//                 return DropdownMenuItem<String>(
//                   value: option,
//                   child: Text(option),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   interestPayout = value!;
//                 });
//               },
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16),
//             Text('TDS Rate (%)', style: TextStyle(fontWeight: FontWeight.bold)),
//             Slider(
//               value: tdsRate,
//               min: 0,
//               max: 30,
//               divisions: 30,
//               label: tdsRate.toStringAsFixed(1),
//               onChanged: (value) {
//                 setState(() {
//                   tdsRate = value;
//                 });
//               },
//             ),
//             SizedBox(height: 24),
//             Center(
//               child: ElevatedButton(
//                 onPressed: calculateFD,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
//                   child: Text('Calculate FD', style: TextStyle(fontSize: 18)),
//                 ),
//               ),
//             ),
//             SizedBox(height: 32),
//             // if (interestPaid > 0)
//             //   Card(
//             //     elevation: 4,
//             //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             //     child: Padding(
//             //       padding: EdgeInsets.all(16),
//             //       child: Column(
//             //         crossAxisAlignment: CrossAxisAlignment.start,
//             //         children: [
//             //           Text('FD Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             //           Divider(),
//             //           SizedBox(height: 8),
//             //           Text('Interest Paid: ₹ ${interestPaid.toStringAsFixed(2)}'),
//             //           Text('Interest Paid (Post-TDS): ₹ ${effectiveInterestPaid.toStringAsFixed(2)}'),
//             //           Text('Effective Interest Rate: ${effectiveRate.toStringAsFixed(2)} % per annum'),
//             //         ],
//             //       ),
//             //     ),
//             //   ),
//             if (interestPaid > 0)
//               Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('FD Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                       Divider(),
//                       SizedBox(height: 8),
//                       Text('Total Interest Paid: ₹ ${interestPaid.toStringAsFixed(2)}'),
//                       Text('Interest Paid (Post-TDS): ₹ ${effectiveInterestPaid.toStringAsFixed(2)}'),
//                       Text('Effective Interest Rate: ${effectiveRate.toStringAsFixed(2)} % per annum'),
//                       SizedBox(height: 8),
//                       Text('Interest Breakdown (${interestPayout}):'),
//                       Text('Per Payout Interest: ₹ ${_interestPerPayout.toStringAsFixed(2)}'),
//                       Text('Per Payout Interest (Post-TDS): ₹ ${_netInterestPerPayout.toStringAsFixed(2)}'),
//                       if (interestPayout == 'Monthly')
//                         Text('Monthly Interest: ₹ ${_netInterestPerPayout.toStringAsFixed(2)}'),
//                     ],
//                   ),
//                 ),
//               ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
// ////////////////////////////// ANOTHER VERSION
//
// class FDModernApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'FD Calculator',
//       debugShowCheckedModeBanner: false,
//       themeMode: ThemeMode.system,
//       theme: ThemeData.light().copyWith(
//         useMaterial3: true,
//         primaryColor: Color(0xFF00ACC1),
//         scaffoldBackgroundColor: Colors.transparent,
//         textTheme: TextTheme(
//           bodyMedium: TextStyle(color: Color(0xFF004D40)),
//           bodyLarge: TextStyle(color: Color(0xFF004D40)),
//         ),
//         sliderTheme: SliderThemeData(
//           activeTrackColor: Color(0xFF00ACC1),
//           thumbColor: Color(0xFF00ACC1),
//         ),
//       ),
//       darkTheme: ThemeData.dark().copyWith(
//         useMaterial3: true,
//         primaryColor: Color(0xFF00BCD4),
//         scaffoldBackgroundColor: Colors.transparent,
//         textTheme: TextTheme(
//           bodyMedium: TextStyle(color: Colors.white70),
//           bodyLarge: TextStyle(color: Colors.white70),
//         ),
//         sliderTheme: SliderThemeData(
//           activeTrackColor: Color(0xFF00BCD4),
//           thumbColor: Color(0xFF00BCD4),
//         ),
//       ),
//       home: FDModernPage(),
//     );
//   }
// }
//
// class FDModernPage extends StatefulWidget {
//   @override
//   _FDModernPageState createState() => _FDModernPageState();
// }
//
// class _FDModernPageState extends State<FDModernPage>
//     with SingleTickerProviderStateMixin {
//   double principal = 100000;
//   double roi = 6.5;
//   int years = 1;
//   int months = 0;
//   String interestPayout = 'Maturity';
//   double tdsRate = 10.0;
//
//   double interestPaid = 0.0;
//   double effectiveInterestPaid = 0.0;
//   double effectiveRate = 0.0;
//   double _interestPerPayout = 0.0;
//   double _netInterestPerPayout = 0.0;
//   int _payoutFrequencyCount = 1;
//
//   List<String> payoutOptions = ['Maturity', 'Quarterly', 'Monthly', 'Half-Yearly'];
//
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 800));
//     _animation = Tween<double>(begin: 0, end: 0).animate(
//         CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
//   }
//
//   void calculateFD() {
//     double tenureInYears = years + months / 12;
//     double n = 1;
//     int payoutFrequency = 1;
//
//     if (interestPayout == 'Monthly') {
//       n = 12;
//       payoutFrequency = (years * 12 + months);
//     } else if (interestPayout == 'Quarterly') {
//       n = 4;
//       payoutFrequency = ((years * 12 + months) / 3).ceil();
//     } else if (interestPayout == 'Half-Yearly') {
//       n = 2;
//       payoutFrequency = ((years * 12 + months) / 6).ceil();
//     } else if (interestPayout == 'Maturity') {
//       n = 1;
//       payoutFrequency = 1;
//     }
//
//     double amount = principal * pow((1 + roi / 100 / n), n * tenureInYears);
//     double interest = amount - principal;
//
//     double tds = interest * (tdsRate / 100);
//     double netInterest = interest - tds;
//
//     double effectiveROI = (netInterest / principal) / tenureInYears * 100;
//
//     double interestPerPayout = interest / payoutFrequency;
//     double netInterestPerPayout = netInterest / payoutFrequency;
//
//     _animation = Tween<double>(begin: 0, end: netInterest)
//         .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
//
//     _animationController.forward(from: 0);
//
//     setState(() {
//       interestPaid = interest;
//       effectiveInterestPaid = netInterest;
//       effectiveRate = effectiveROI;
//       _interestPerPayout = interestPerPayout;
//       _netInterestPerPayout = netInterestPerPayout;
//       _payoutFrequencyCount = payoutFrequency;
//     });
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   Widget glassCard(Widget child) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(20),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Theme.of(context).brightness == Brightness.dark
//                 ? Colors.black.withOpacity(0.3)
//                 : Colors.white.withOpacity(0.3),
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(
//               color: Theme.of(context).brightness == Brightness.dark
//                   ? Colors.white24
//                   : Colors.white30,
//             ),
//           ),
//           child: child,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: isDark
//                   ? [Color(0xFF004D40), Color(0xFF00796B)]
//                   : [Color(0xFFE0F7FA), Color(0xFFB2EBF2)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: SingleChildScrollView(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 SizedBox(height: 16),
//                 Text(
//                   "FD Calculator",
//                   style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: isDark ? Colors.white : Color(0xFF004D40)),
//                 ),
//                 SizedBox(height: 24),
//
//                 // Principal Input
//                 glassCard(Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: TextField(
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                         prefixText: '₹ ',
//                         labelText: 'Principal Amount',
//                         border: InputBorder.none,
//                         labelStyle: TextStyle(
//                             color: isDark ? Colors.white70 : Color(0xFF004D40))),
//                     style: TextStyle(color: isDark ? Colors.white : Color(0xFF004D40)),
//                     onChanged: (value) {
//                       principal = double.tryParse(value) ?? principal;
//                     },
//                     controller:
//                     TextEditingController(text: principal.toStringAsFixed(0)),
//                   ),
//                 )),
//                 SizedBox(height: 16),
//
//                 // ROI Slider
//                 glassCard(Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Rate of Interest (%)',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: isDark ? Colors.white : Color(0xFF004D40)),
//                       ),
//                       Slider(
//                         value: roi,
//                         min: 1,
//                         max: 15,
//                         divisions: 140,
//                         label: roi.toStringAsFixed(2),
//                         activeColor:
//                         isDark ? Color(0xFF00BCD4) : Color(0xFF00ACC1),
//                         inactiveColor: Colors.white30,
//                         onChanged: (value) {
//                           setState(() {
//                             roi = value;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 )),
//                 SizedBox(height: 16),
//
//                 // Tenure
//                 glassCard(Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Tenure',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: isDark ? Colors.white : Color(0xFF004D40)),
//                       ),
//                       SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: TextField(
//                               keyboardType: TextInputType.number,
//                               decoration: InputDecoration(
//                                   labelText: 'Years',
//                                   border: InputBorder.none,
//                                   labelStyle: TextStyle(
//                                       color: isDark
//                                           ? Colors.white70
//                                           : Color(0xFF004D40))),
//                               style: TextStyle(
//                                   color: isDark ? Colors.white : Color(0xFF004D40)),
//                               onChanged: (value) {
//                                 years = int.tryParse(value) ?? years;
//                               },
//                               controller:
//                               TextEditingController(text: years.toString()),
//                             ),
//                           ),
//                           SizedBox(width: 16),
//                           Expanded(
//                             child: TextField(
//                               keyboardType: TextInputType.number,
//                               decoration: InputDecoration(
//                                   labelText: 'Months',
//                                   border: InputBorder.none,
//                                   labelStyle: TextStyle(
//                                       color: isDark
//                                           ? Colors.white70
//                                           : Color(0xFF004D40))),
//                               style: TextStyle(
//                                   color: isDark ? Colors.white : Color(0xFF004D40)),
//                               onChanged: (value) {
//                                 months = int.tryParse(value) ?? months;
//                               },
//                               controller:
//                               TextEditingController(text: months.toString()),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 )),
//                 SizedBox(height: 16),
//
//                 // Interest Payout Dropdown
//                 glassCard(Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: DropdownButtonFormField<String>(
//                     value: interestPayout,
//                     items: payoutOptions.map((option) {
//                       return DropdownMenuItem<String>(
//                         value: option,
//                         child: Text(option,
//                             style: TextStyle(
//                                 color: isDark ? Colors.white : Color(0xFF004D40))),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         interestPayout = value!;
//                       });
//                     },
//                     decoration: InputDecoration(border: InputBorder.none),
//                     dropdownColor:
//                     isDark ? Colors.black87 : Colors.white.withOpacity(0.9),
//                   ),
//                 )),
//                 SizedBox(height: 16),
//
//                 // TDS Slider
//                 glassCard(Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'TDS Rate (%)',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: isDark ? Colors.white : Color(0xFF004D40)),
//                       ),
//                       Slider(
//                         value: tdsRate,
//                         min: 0,
//                         max: 30,
//                         divisions: 30,
//                         label: tdsRate.toStringAsFixed(1),
//                         activeColor:
//                         isDark ? Color(0xFF00BCD4) : Color(0xFF00ACC1),
//                         inactiveColor: Colors.white30,
//                         onChanged: (value) {
//                           setState(() {
//                             tdsRate = value;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 )),
//                 SizedBox(height: 24),
//
//                 ElevatedButton(
//                   onPressed: calculateFD,
//                   child: Padding(
//                     padding:
//                     const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
//                     child: Text("Calculate", style: TextStyle(fontSize: 18)),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     primary: isDark ? Color(0xFF00BCD4) : Color(0xFF00ACC1),
//                     onPrimary: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 32),
//
//                 // Result Card
//                 if (interestPaid > 0)
//                   glassCard(Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       children: [
//                         Text(
//                           "Results",
//                           style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               color: isDark ? Colors.white : Color(0xFF004D40)),
//                         ),
//                         SizedBox(height: 16),
//                         AnimatedBuilder(
//                           animation: _animationController,
//                           builder: (context, child) {
//                             return Column(
//                               children: [
//                                 resultRow(
//                                     "Total Interest Paid",
//                                     interestPaid.toStringAsFixed(2)),
//                                 resultRow(
//                                     "Net Interest Paid",
//                                     _animation.value.toStringAsFixed(2)),
//                                 resultRow("Effective ROI",
//                                     "${effectiveRate.toStringAsFixed(2)}%"),
//                                 Divider(color: Colors.white30, thickness: 1),
//                                 resultRow("Interest per ${interestPayout}",
//                                     _interestPerPayout.toStringAsFixed(2)),
//                                 resultRow("Net per ${interestPayout}",
//                                     _netInterestPerPayout.toStringAsFixed(2)),
//                               ],
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   )),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget resultRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(label,
//               style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Theme.of(context).brightness == Brightness.dark
//                       ? Colors.white70
//                       : Color(0xFF004D40))),
//           Text(value,
//               style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Theme.of(context).brightness == Brightness.dark
//                       ? Colors.white
//                       : Color(0xFF004D40))),
//         ],
//       ),
//     );
//   }
// }
//
//
// /////////////////////// ONE MORE VERSION
//
//
//
// class FDModernApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'FD Calculator',
//       debugShowCheckedModeBanner: false,
//       themeMode: ThemeMode.system,
//       theme: ThemeData.light().copyWith(
//         useMaterial3: true,
//         primaryColor: Colors.teal,
//         colorScheme: ColorScheme.light(
//           primary: Colors.teal,
//           secondary: Colors.tealAccent,
//         ),
//       ),
//       darkTheme: ThemeData.dark().copyWith(
//         useMaterial3: true,
//         primaryColor: Colors.teal,
//         colorScheme: ColorScheme.dark(
//           primary: Colors.teal,
//           secondary: Colors.tealAccent,
//         ),
//       ),
//       home: FDModernPage(),
//     );
//   }
// }
//
// class FDModernPage extends StatefulWidget {
//   @override
//   _FDModernPageState createState() => _FDModernPageState();
// }
//
// class _FDModernPageState extends State<FDModernPage>
//     with SingleTickerProviderStateMixin {
//   double principal = 100000;
//   double roi = 6.5;
//   int years = 1;
//   int months = 0;
//   String interestPayout = 'Maturity';
//   double tdsRate = 10.0;
//
//   double interestPaid = 0.0;
//   double effectiveInterestPaid = 0.0;
//   double effectiveRate = 0.0;
//   double _interestPerPayout = 0.0;
//   double _netInterestPerPayout = 0.0;
//   int _payoutFrequencyCount = 1;
//
//   List<String> payoutOptions = ['Maturity', 'Quarterly', 'Monthly', 'Half-Yearly'];
//
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController =
//         AnimationController(vsync: this, duration: Duration(milliseconds: 800));
//     _animation = Tween<double>(begin: 0, end: 0).animate(
//         CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
//   }
//
//   void calculateFD() {
//     double tenureInYears = years + months / 12;
//     double n = 1;
//     int payoutFrequency = 1;
//
//     if (interestPayout == 'Monthly') {
//       n = 12;
//       payoutFrequency = (years * 12 + months);
//     } else if (interestPayout == 'Quarterly') {
//       n = 4;
//       payoutFrequency = ((years * 12 + months) / 3).ceil();
//     } else if (interestPayout == 'Half-Yearly') {
//       n = 2;
//       payoutFrequency = ((years * 12 + months) / 6).ceil();
//     } else if (interestPayout == 'Maturity') {
//       n = 1;
//       payoutFrequency = 1;
//     }
//
//     double amount = principal * pow((1 + roi / 100 / n), n * tenureInYears);
//     double interest = amount - principal;
//
//     double tds = interest * (tdsRate / 100);
//     double netInterest = interest - tds;
//
//     double effectiveROI = (netInterest / principal) / tenureInYears * 100;
//
//     double interestPerPayout = interest / payoutFrequency;
//     double netInterestPerPayout = netInterest / payoutFrequency;
//
//     _animation = Tween<double>(begin: 0, end: netInterest)
//         .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
//
//     _animationController.forward(from: 0);
//
//     setState(() {
//       interestPaid = interest;
//       effectiveInterestPaid = netInterest;
//       effectiveRate = effectiveROI;
//       _interestPerPayout = interestPerPayout;
//       _netInterestPerPayout = netInterestPerPayout;
//       _payoutFrequencyCount = payoutFrequency;
//     });
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   Widget glassCard(Widget child) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(20),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(color: Colors.white24),
//           ),
//           child: child,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.teal.shade800, Colors.tealAccent.shade200],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: SingleChildScrollView(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 SizedBox(height: 16),
//                 Text(
//                   "FD Calculator",
//                   style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//                 SizedBox(height: 24),
//
//                 // Principal Input
//                 glassCard(Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: TextField(
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                         prefixText: '₹ ',
//                         labelText: 'Principal Amount',
//                         border: InputBorder.none,
//                         labelStyle: TextStyle(color: Colors.white70)),
//                     style: TextStyle(color: Colors.white),
//                     onChanged: (value) {
//                       principal = double.tryParse(value) ?? principal;
//                     },
//                     controller:
//                     TextEditingController(text: principal.toStringAsFixed(0)),
//                   ),
//                 )),
//                 SizedBox(height: 16),
//
//                 // ROI Slider
//                 glassCard(Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Rate of Interest (%)',
//                         style:
//                         TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//                       ),
//                       Slider(
//                         value: roi,
//                         min: 1,
//                         max: 15,
//                         divisions: 140,
//                         label: roi.toStringAsFixed(2),
//                         activeColor: Colors.tealAccent,
//                         inactiveColor: Colors.white30,
//                         onChanged: (value) {
//                           setState(() {
//                             roi = value;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 )),
//                 SizedBox(height: 16),
//
//                 // Tenure
//                 glassCard(Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Tenure',
//                         style:
//                         TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//                       ),
//                       SizedBox(height: 8),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: TextField(
//                               keyboardType: TextInputType.number,
//                               decoration: InputDecoration(
//                                   labelText: 'Years', border: InputBorder.none, labelStyle: TextStyle(color: Colors.white70)),
//                               style: TextStyle(color: Colors.white),
//                               onChanged: (value) {
//                                 years = int.tryParse(value) ?? years;
//                               },
//                               controller: TextEditingController(text: years.toString()),
//                             ),
//                           ),
//                           SizedBox(width: 16),
//                           Expanded(
//                             child: TextField(
//                               keyboardType: TextInputType.number,
//                               decoration: InputDecoration(
//                                   labelText: 'Months', border: InputBorder.none, labelStyle: TextStyle(color: Colors.white70)),
//                               style: TextStyle(color: Colors.white),
//                               onChanged: (value) {
//                                 months = int.tryParse(value) ?? months;
//                               },
//                               controller: TextEditingController(text: months.toString()),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 )),
//                 SizedBox(height: 16),
//
//                 // Interest Payout Dropdown
//                 glassCard(Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: DropdownButtonFormField<String>(
//                     value: interestPayout,
//                     items: payoutOptions.map((option) {
//                       return DropdownMenuItem<String>(
//                         value: option,
//                         child: Text(option, style: TextStyle(color: Colors.white)),
//                       );
//                     }).toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         interestPayout = value!;
//                       });
//                     },
//                     decoration: InputDecoration(border: InputBorder.none),
//                     dropdownColor: Colors.black87,
//                   ),
//                 )),
//                 SizedBox(height: 16),
//
//                 // TDS Slider
//                 glassCard(Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'TDS Rate (%)',
//                         style:
//                         TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//                       ),
//                       Slider(
//                         value: tdsRate,
//                         min: 0,
//                         max: 30,
//                         divisions: 30,
//                         label: tdsRate.toStringAsFixed(1),
//                         activeColor: Colors.tealAccent,
//                         inactiveColor: Colors.white30,
//                         onChanged: (value) {
//                           setState(() {
//                             tdsRate = value;
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                 )),
//                 SizedBox(height: 24),
//
//                 ElevatedButton(
//                   onPressed: calculateFD,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
//                     child: Text("Calculate", style: TextStyle(fontSize: 18)),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.tealAccent.shade700,
//                     onPrimary: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: 32),
//
//                 // Result Card
//                 if (interestPaid > 0)
//                   glassCard(Padding(
//                     padding: EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "FD Summary",
//                           style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white),
//                         ),
//                         Divider(color: Colors.white38),
//                         SizedBox(height: 8),
//                         AnimatedBuilder(
//                           animation: _animation,
//                           builder: (context, child) {
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Total Interest Paid: ₹ ${(_animation.value).toStringAsFixed(2)}',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 Text(
//                                   'Interest Paid (Post-TDS): ₹ ${(_netInterestPerPayout * _payoutFrequencyCount).toStringAsFixed(2)}',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 Text(
//                                   'Effective Interest Rate: ${effectiveRate.toStringAsFixed(2)} % per annum',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 SizedBox(height: 8),
//                                 Text('Interest Breakdown (${interestPayout}):',
//                                     style: TextStyle(color: Colors.white70)),
//                                 Text(
//                                   'Per Payout Interest: ₹ ${_interestPerPayout.toStringAsFixed(2)}',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 Text(
//                                   'Per Payout Interest (Post-TDS): ₹ ${_netInterestPerPayout.toStringAsFixed(2)}',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 if (interestPayout == 'Monthly')
//                                   Text(
//                                     'Monthly Interest: ₹ ${_netInterestPerPayout.toStringAsFixed(2)}',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                               ],
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   )),
//                 SizedBox(height: 32),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
