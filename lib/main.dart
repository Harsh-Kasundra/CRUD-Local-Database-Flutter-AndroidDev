import 'package:database_audi/myDatabase.dart';
import 'package:database_audi/user_list_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(future: MyDataBase().initDatabase(), builder: (context, snapshot) {
        if(snapshot.hasData){
          return UserListPage();
        }
        else {return CircularProgressIndicator();}
      },),
    );
  }
}