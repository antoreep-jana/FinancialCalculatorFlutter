import 'package:flutter/material.dart';
import '../../database/db_helper.dart';
import 'history_details_page.dart';

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
    // final tables = await DBHelper.instance.getAllTables();
    // final sip_data = await DBHelper.instance.getAl
    setState(() => history = data);

    // print("History : $history");
    //
    // print("Tables as of now $tables");


  }

  Future<void> _deleteRecord(int id, String table) async{
    await DBHelper.instance.deleteData(id, table);
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
              return HistoryPageItem(item : item, type : item['type'], onDelete : _deleteRecord);
            },
                    ),
          ),]
      ),
    );
  }
}



class HistoryPageItem extends StatefulWidget {
  final Map<String, dynamic> item;
  final String type;
  final Future<void> Function(int, String) onDelete;
   HistoryPageItem({super.key, required this.item, required this.type, required this.onDelete});

  @override
  State<HistoryPageItem> createState() => _HistoryPageItemState();
}

class _HistoryPageItemState extends State<HistoryPageItem> {

  void _openDetailPage(String table){
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => HistoryDetailsPage(item : widget.item, onDelete : widget.onDelete, table : table))
    );
  }

  // void _openDetailPage(){
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => CalculationDetailPage(item : widget.item))
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    if (widget.type == "SI" || widget.type == "CI")
    return ListTile(
      onTap: () {
        _openDetailPage("calculations");
      },
      leading: Icon(Icons.calculate),
      title: Text("₹${widget.item['principal']} @ ${widget.item['rate']}% for ${widget.item['time']} yrs"),
      subtitle: Text("Interest: ₹${widget.item['result']}    Type: ${widget.item['type']}"),
      //trailing: Text(item['createdAt'].substring(0, 10)),
      trailing: IconButton(onPressed: (){

        widget.onDelete(widget.item['id'], "calculations");
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Note deleted"), //${item['id']}"),
              duration: Duration(milliseconds: 300),
            ));

        // _deleteRecord(widget.item['id']);

      }, icon: Icon(Icons.delete_outline, color: Colors.redAccent,)),
    );
    else if (widget.type == "SIP"){
      return ListTile(
        leading: Icon(Icons.calculate),
        title: Text("₹${widget.item['investment']} @ ${widget.item['expected_returns']}% for ${widget.item['time']} yrs"),
        subtitle: Text("Future Value: ₹${widget.item['futureValue']}    Type: ${widget.item['type']}"),
        //trailing: Text(item['createdAt'].substring(0, 10)),
        trailing: IconButton(onPressed: (){
          widget.onDelete(widget.item['id'], 'sip_calculations');
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Note deleted"), //${item['id']}"),
                duration: Duration(milliseconds: 300),
              ));

          // _deleteRecord(widget.item['id']);

        }, icon: Icon(Icons.delete_outline, color: Colors.redAccent,)),
      );
    }else if(widget.type == "Lumpsum"){
      return ListTile(
        leading: Icon(Icons.calculate),
        title: Text("₹${widget.item['investment']} @ ${widget.item['returns']}% for ${widget.item['duration']} yrs"),
        subtitle: Text("Future Value: ₹${widget.item['futureValue']}    Type: ${widget.item['type']}"),
        //trailing: Text(item['createdAt'].substring(0, 10)),
        trailing: IconButton(onPressed: (){
          widget.onDelete(widget.item['id'], 'lumpsum_calculations');
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Note deleted"), //${item['id']}"),
                duration: Duration(milliseconds: 300),
              ));

          // _deleteRecord(widget.item['id']);

        }, icon: Icon(Icons.delete_outline, color: Colors.redAccent,)),
      );
    }else if (widget.type == 'SWP'){
      return ListTile(
        leading: Icon(Icons.calculate),
        title: Text("₹${widget.item['lumpsum']} @ ${widget.item['rate']}% withdrawn ${widget.item['monthly_withdrawl']} for ${widget.item['time']} yrs"),
        subtitle: Text("Remaining Value: ₹${widget.item['remaining']}    Type: ${widget.item['type']}"),
        //trailing: Text(item['createdAt'].substring(0, 10)),
        trailing: IconButton(onPressed: (){
          widget.onDelete(widget.item['id'], 'swp_calculations');
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Note deleted"), //${item['id']}"),
                duration: Duration(milliseconds: 300),
              ));

          // _deleteRecord(widget.item['id']);

        }, icon: Icon(Icons.delete_outline, color: Colors.redAccent,)),
      );
    }else if(widget.type == "EMI"){
      return ListTile(
        leading: Icon(Icons.calculate),
        title: Text("₹${widget.item['amount']} @ ${widget.item['rate']}% EMI of ${widget.item['monthlyPayment']} for ${widget.item['months']} months"),
        subtitle: Text("Total Repayment Amount: ₹${widget.item['totalRepayment']}    Type: ${widget.item['type']}"),
        //trailing: Text(item['createdAt'].substring(0, 10)),
        trailing: IconButton(onPressed: (){
          widget.onDelete(widget.item['id'], 'emi_calculations');
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Note deleted"), //${item['id']}"),
                duration: Duration(milliseconds: 300),
              ));

          // _deleteRecord(widget.item['id']);

        }, icon: Icon(Icons.delete_outline, color: Colors.redAccent,)),
      );
    }
    else{
      return Card(

      );
    }
  }
}
