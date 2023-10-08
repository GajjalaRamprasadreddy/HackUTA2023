class Ocassion {
  String? ocassion;
  String? ocassionDate;


  Ocassion({
    this.ocassion,
    this.ocassionDate,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (ocassion != null) {
      result.addAll({'ocassion': ocassion});
    }
    if (ocassionDate != null) {
      result.addAll({'ocassionDate': ocassionDate});
    }

    return result;
  }

  factory Ocassion.fromMap(Map<String, dynamic> map) {
    return Ocassion(
      ocassion: map['ocassion'],
      ocassionDate: map['ocassionDate'],
    );
  }

}
