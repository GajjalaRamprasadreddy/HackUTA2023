class Users {
  String? fName;
  String? lName;
  String? dob;
  String? emailId;
  String? mobileNumber;

  Users({
    this.fName,
    this.lName,
    this.dob,
    this.emailId,
    this.mobileNumber,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (fName != null) {
      result.addAll({'fName': fName});
    }
    if (lName != null) {
      result.addAll({'lName': lName});
    }
    if (dob != null) {
      result.addAll({'dob': dob});
    }
    if (emailId != null) {
      result.addAll({'emailId': emailId});
    }
    if (mobileNumber != null) {
      result.addAll({'mobileNumber': mobileNumber});
    }
    return result;
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      fName: map['fName'],
      lName: map['lName'],
      dob: map['dob'],
      emailId: map['emailId'],
      mobileNumber: map['mobileNumber'],
    );
  }

}
