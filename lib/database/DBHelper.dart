import 'package:local_database/model/employee.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static late Database _database;

  Future<Database> get database async {
    _database = await initDb();

    return _database;
  }

  initDb() async {
    final theDb = openDatabase(
      join(await getDatabasesPath(), 'test.db'),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE Employee(id INTEGER PRIMARY KEY, firstName TEXT, secondName TEXT, mobileNo TEXT, emailId TEXT)',
        );
      },
      version: 1,
    );

    /*  io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "test.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);*/

    return theDb;
  }

/*  void _onCreate() async {
    await db.execute(
        "CREATE TABLE Employee(id INTEGER PRIMARY KEY, firstName TEXT, secondName TEXT, mobileNo TEXT, emailId TEXT)");

    print("Created tables");
  }*/

  void saveEmployees(Employee employee) async {
    var dbClient = await database;

    await dbClient.transaction((txn) async {
      return await txn.rawInsert(
          'INSERT INTO Employee(firstname,secondName,mobileNo,emailId) VALUES( ' +
              '\'' +
              employee.firstName +
              '\'' +
              ',' +
              '\'' +
              employee.secondName +
              '\'' +
              ',' +
              '\'' +
              employee.mobileNo +
              '\'' +
              ',' +
              '\'' +
              employee.emailId +
              '\'' +
              ')');
    });
    print("save tables");
  }

  Future<List<Employee>> getEmployees() async {
    var dbClient = await database;

    List<Map> list = await dbClient.rawQuery('SELECT * FROM Employee');

    List<Employee> employees = [];

    for (int i = 0; i < list.length; i++) {
      employees.add(new Employee(list[i]["firstName"], list[i]["secondName"],
          list[i]["mobileNo"], list[i]["emailId"]));
    }

    print(employees.length);

    return employees;
  }
}
