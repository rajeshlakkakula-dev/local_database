import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:local_database/database/DBHelper.dart';
import 'package:local_database/model/employee.dart';

import 'employeelist.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'SQL Database',
      theme: new ThemeData(primarySwatch: Colors.blueGrey),
      home: new MyHomePage(title: 'SQL DB Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  String title;

  @override
  State<MyHomePage> createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Employee employee = Employee("", "", "", "");

  late String firstName;
  late String secondName;
  late String mobileNo;
  late String emailId;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee'),
        actions: [
          IconButton(
              onPressed: () {
                navigateToEmployeeList();
              },
              icon: Icon(Icons.view_list))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (val) => val?.length == 0 ? "Enter FirstName" : null,
                onSaved: (val) => firstName = val!,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: 'Second Name'),
                validator: (val) => val?.length == 0 ? "Enter Second" : null,
                onSaved: (val) => secondName = val!,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Mobile No'),
                validator: (val) => val?.length == 0 ? "Enter Mobile No" : null,
                onSaved: (val) => mobileNo = val!,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: 'Email Id'),
                validator: (val) => val?.length == 0 ? "Enter Email Id" : null,
                onSaved: (val) => emailId = val!,
              ),
              Container(
                child: ElevatedButton(
                  onPressed: submit,
                  child: Text('Save Employee'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
    } else {
      return null;
    }

    var employee = Employee(firstName, secondName, mobileNo, emailId);

    var dbHelper = DBHelper();

    dbHelper.saveEmployees(employee);
    showSnackBar("Data Saved Successfully");
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void navigateToEmployeeList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyEmployeeList()),
    );
  }
}
