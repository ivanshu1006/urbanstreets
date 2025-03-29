class GetUserDataModel {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? mobileNumber;
  String? email;
  String? profilePicUrl;
  String? location;
  double? latitude;
  double? longitude;
  String? bio;
  int? followers;
  int? followings;
  List<String>? interests;
  String? gender;
  String? birthDate;
  int? posts;
  bool? isPremiumMember;
  bool? isVerified;
  String? idNumber;
  String? idPhotoUrl;
  String? createdAt;
  String? updatedAt;

  GetUserDataModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.username,
      this.mobileNumber,
      this.email,
      this.profilePicUrl,
      this.location,
      this.latitude,
      this.longitude,
      this.bio,
      this.followers,
      this.followings,
      this.interests,
      this.gender,
      this.birthDate,
      this.posts,
      this.isPremiumMember,
      this.isVerified,
      this.idNumber,
      this.idPhotoUrl,
      this.createdAt,
      this.updatedAt});

  GetUserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    profilePicUrl = json['profile_pic_url'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    bio = json['bio'];
    followers = json['followers'];
    followings = json['followings'];
    interests = json['interests'].cast<String>();
    gender = json['gender'];
    birthDate = json['birth_date'];
    posts = json['posts'];
    isPremiumMember = json['is_premium_member'];
    isVerified = json['is_verified'];
    idNumber = json['id_number'];
    idPhotoUrl = json['id_photo_url'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['mobile_number'] = this.mobileNumber;
    data['email'] = this.email;
    data['profile_pic_url'] = this.profilePicUrl;
    data['location'] = this.location;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['bio'] = this.bio;
    data['followers'] = this.followers;
    data['followings'] = this.followings;
    data['interests'] = this.interests;
    data['gender'] = this.gender;
    data['birth_date'] = this.birthDate;
    data['posts'] = this.posts;
    data['is_premium_member'] = this.isPremiumMember;
    data['is_verified'] = this.isVerified;
    data['id_number'] = this.idNumber;
    data['id_photo_url'] = this.idPhotoUrl;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
