import 'package:database_audi/myDatabase.dart';
import 'package:database_audi/user_entry_page.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('User List'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return UserEntryPage(map: null);
                      },
                    ),
                  ).then(
                    (value) {
                      setState(() {});
                    },
                  );
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future: MyDataBase().getUserListFromUserTbl(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(snapshot.data![index]['Name']),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return UserEntryPage(
                                          map: snapshot.data![index]);
                                    },
                                  )).then(
                                    (value) {
                                      setState(() {});
                                    },
                                  );
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  MyDataBase().deleteUserFromUserTable(
                                      userId: snapshot.data![index]['UserId']);
                                  setState(() {});
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data!.length,
                );
              } else {
                return Center(
                  child: Text("No User Found"),
                );
              }
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
