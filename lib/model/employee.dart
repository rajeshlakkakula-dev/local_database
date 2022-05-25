

class Employee {
  late String firstName;
  late String secondName;
  late String mobileNo;
  late String emailId;

  Employee(this.firstName, this.secondName, this.mobileNo, this.emailId);

  Employee.fromMap(Map map) {
    firstName = map[firstName];
    secondName = map[secondName];
    mobileNo = map[mobileNo];
    emailId = map[emailId];
  }
}
