import 'package:database_audi/myDatabase.dart';
import 'package:flutter/material.dart';

class UserEntryPage extends StatefulWidget {
  final Map<String, dynamic>? map;

  UserEntryPage({super.key, required this.map});

  @override
  State<UserEntryPage> createState() => _UserEntryPageState();
}

class _UserEntryPageState extends State<UserEntryPage> {
  GlobalKey<FormState> _globalKey = GlobalKey();
  TextEditingController controller = TextEditingController();
  MyDataBase db = MyDataBase();

  @override
  void initState() {
    super.initState();
    controller.text = widget.map != null ? widget.map!['Name'] : '';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("User Details"),
        ),
        body: Form(
          child: Column(
            children: [
              TextFormField(
                controller: controller,
                key: _globalKey,
                validator: (value) {
                  RegExp alphaRegex = RegExp(r'^[a-zA-Z]+$');
                  if (value!.isEmpty || !alphaRegex.hasMatch(value)) {
                    return 'Please enter an Alphabetical values only';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  hintText: 'Enter Your Name',
                  labelText: 'Enter Your Name',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  print('widget.map: ${widget.map}');
                    if (widget.map != null) {
                      print('update');
                      await db.updateUserDetailIntoUserTable(
                          name: controller.text.toString(),
                          userId: widget.map!['UserId']);
                    } else {
                      print('insert');
                      await db.insertRecordIntoUserTable(
                          controller.text.toString());
                    }
                    Navigator.of(context).pop(true);
                  // }
                },

                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
