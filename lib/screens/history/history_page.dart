import 'package:flutter/material.dart';
import '../../database/db_helper.dart';


// TODO: Make the History Page better. Tappable Cards, Filters, Search etc.

// TODO:

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final data = await DBHelper.instance.getAllCalculations();
    setState(() => history = data);
  }

  Future<void> _deleteRecord(int id) async{
    await DBHelper.instance.deleteData(id);
    _loadHistory();
  }

  Future<void> _deleteAll() async{
    await DBHelper.instance.deleteAll();
    _loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculation History"),
      actions: [
        //IconButton(onPressed: _deleteAll, icon: Icon(Icons.delete, color: Colors.red,))
        ],
      ),
      body:

      Column(
        children: [
          ElevatedButton.icon(onPressed: (){
            _deleteAll();
          }, icon: Icon(Icons.delete, color: Colors.red,), label: Text("Clear All"),),
          Expanded(
            child: ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              final item = history[index];
              return ListTile(
                leading: Icon(Icons.calculate),
                title: Text("₹${item['principal']} @ ${item['rate']}% for ${item['time']} yrs"),
                subtitle: Text("Interest: ₹${item['result']}"),
                //trailing: Text(item['createdAt'].substring(0, 10)),
                trailing: IconButton(onPressed: (){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("Note deleted"), //${item['id']}"),
                              duration: Duration(milliseconds: 300),
                          ));

                        _deleteRecord(item['id']);

                }, icon: Icon(Icons.delete_outline, color: Colors.redAccent,)),
              );
            },
                    ),
          ),]
      ),
    );
  }
}
