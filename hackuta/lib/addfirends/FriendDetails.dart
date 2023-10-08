import 'addOcassionCard/Ocassion.dart';

class FriendDetails {
  String? profileImage;
  String? name;
  String? nickName;
  String? noOfYears;
  String? memories;
  String? mobileNumber;
  String? somethingUnique;
  Map<String?, String?>? lisOfOcassion;

  FriendDetails(
      {
        this.profileImage,
        this.name,
      this.nickName,
      this.noOfYears,
      this.memories,
      this.mobileNumber,
      this.somethingUnique,
      this.lisOfOcassion});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (name != null) {
      result.addAll({'fName': name});
    }
    if (profileImage != null) {
      result.addAll({'profileImage': profileImage});
    }
    if (nickName != null) {
      result.addAll({'nickName': nickName});
    }
    if (noOfYears != null) {
      result.addAll({'noOfYears': noOfYears});
    }
    if (mobileNumber != null) {
      result.addAll({'emailId': mobileNumber});
    }
    if (somethingUnique != null) {
      result.addAll({'somethingUnique': somethingUnique});
    }
    if (memories != null) {
      result.addAll({'memories': memories});
    }
    if (lisOfOcassion != null) {
      result.addAll({'lisOfOcassion': lisOfOcassion});
    }

    return result;
  }

  factory FriendDetails.fromMap(Map<String, dynamic> map) {
    return FriendDetails(
      name: map['fName'],
      nickName: map['nickName'],
      profileImage: map['profileImage'],
      noOfYears: map['noOfYears'],
      memories: map['memories'],
      mobileNumber: map['mobileNumber'],
      somethingUnique: map['somethingUnique'],
      lisOfOcassion: map['lisOfOcassion'],
    );
  }
}
