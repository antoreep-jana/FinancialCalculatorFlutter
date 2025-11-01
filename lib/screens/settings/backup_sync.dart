import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackupAndSync extends StatefulWidget {
  const BackupAndSync({super.key});

  @override
  State<BackupAndSync> createState() => _BackupAndSyncState();
}

class _BackupAndSyncState extends State<BackupAndSync> {

  bool syncValue = true;

  @override
  void initState() {
    super.initState();
    _loadSyncValue();
  }

  _loadSyncValue() async{
  final prefs= await SharedPreferences.getInstance();
  setState(() {
    syncValue = prefs.getBool('syncValue') ?? true;
  });
  }

  _saveSyncValue(bool Value) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('syncValue', Value);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sync with Cloud",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87
                ),
              ),
              const SizedBox(height : 8),
              Text("Enable Automatic sync with cloud account",
                style: TextStyle(
                    fontSize : 14,
                    color : Colors.grey[600]
                ),
              ),
              const SizedBox(height : 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Enable Sync",
                      style : TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                      )
                  ),
                  Switch(
                    value: syncValue, // TODO: Replace with actual sync status
                    onChanged: (bool value){
                      // TODO: Logic to enable/disable syncing
                      // syncValue
                      setState(() {
                        syncValue = value;
                      });

                      _saveSyncValue(value);
                    },
                  )
                ],
              ),

              const SizedBox(height: 16,),
              Divider(),
              const SizedBox(height: 16,),
              Text(
                "Manual Backup",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87
                ),

              ),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: (){}, child: Text("Backup Now")),
              const SizedBox(height: 16,),
              Divider(),
              const SizedBox(height: 16,),
              Text("Restore from backup",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)
              ),
              const SizedBox(height: 8),
              ElevatedButton(onPressed: (){}, child: Text("Restore Now"))

            ],
          ),
        )
    );
  }
}
