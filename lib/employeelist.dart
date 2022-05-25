import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_database/database/DBHelper.dart';
import 'package:local_database/model/employee.dart';

Future<List<Employee>> fetchEmployeesfromDatabase() {
  var dbHelper = DBHelper();

  Future<List<Employee>> employees = dbHelper.getEmployees();

  return employees;
}

class MyEmployeeList extends StatefulWidget {
  const MyEmployeeList({Key? key}) : super(key: key);

  @override
  State<MyEmployeeList> createState() => MyEmployeeListState();
}

class MyEmployeeListState extends State<MyEmployeeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee List"),
      ),
      body: Container(
        child: FutureBuilder<List<Employee>>(
          future: fetchEmployeesfromDatabase(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(
                          snapshot.data![index].firstName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(
                          snapshot.data![index].secondName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),

                        Text(
                          snapshot.data![index].mobileNo,
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 18),
                        ),
                        Text(
                          snapshot.data![index].emailId,
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 18),
                        ),
                        Divider(),

                      ],
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return Container(alignment: AlignmentDirectional.center,
              child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}
