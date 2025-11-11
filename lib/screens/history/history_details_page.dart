import 'package:financial_calculator/screens/history/history_page.dart';
import 'package:flutter/material.dart';

class HistoryDetailsPage extends StatefulWidget {

  final Map<String, dynamic> item;
  final Future<void> Function(int, String) onDelete;
  final String table;

  const HistoryDetailsPage({super.key, required this.item, required this.onDelete, required this.table});

  @override
  State<HistoryDetailsPage> createState() => _HistoryDetailsPageState();
}

class _HistoryDetailsPageState extends State<HistoryDetailsPage> {

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> menuItems = [{'function' : 'Copy' , 'icon' : Icon(Icons.copy)},
      {'function' : 'Share', 'icon' : Icon(Icons.share)}, {'function' : 'Edit' , "icon" : Icon(Icons.edit)}];

    return Scaffold(
      appBar: AppBar(title: Text("Calculation details"),
      centerTitle: true,
      actions: [
          PopupMenuButton(
              
              itemBuilder: (BuildContext context){

                return menuItems.map((item) {
                  return PopupMenuItem(value: item['function'], child: Row(
                    children: [
                      item['icon'],
                      SizedBox(width: 10,),
                      Text(item['function']),
                    ],
                  ), );
                }).toList();

          })

      ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
            widget.onDelete(widget.item['id'], widget.table);
            Navigator.pop(context, "Deleted ${widget.item['id']}");
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Deleted"), duration: Duration(milliseconds: 300),));
      }, child: Icon(Icons.delete),),
      // bottomNavigationBar: BottomNavigationBar(items:  [
      //   BottomNavigationBarItem(icon: Icon(Icons.delete)),
      //   // BottomNavigationBarItem(icon: Icon(Icons.))
      // ]),
      // body : Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: ListView(
      //     children:
      //       widget.item.entries.map(
      //           (entry) => ListTile(
      //             title: Text(entry.key),
      //             subtitle: Text(entry.value.toString()),
      //           )
      //       ).toList(),
      //
      //   ),
      // )

      body : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child : Card(
          shape : RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation : 3,
          child : Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header

                _buildHeader(context, widget.item)

              ],
            )
          )
        )
      )

       //  SingleChildScrollView(child: Column(
       // children: [
       //   Row(
       //       children:
       //       [Text("data"),Text("")])
       //      ]
       //  ),
       //  )
    );
  }


  Widget _buildHeader(BuildContext context, Map<String, dynamic> item){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text("Type : ${item['type']}",
                style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),


          ],
        )
        //  Chip(label: Text("$item.type"), )
      ],
    );
  }
}
