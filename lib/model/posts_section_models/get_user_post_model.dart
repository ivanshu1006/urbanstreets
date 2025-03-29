class GetUserPostsModel {
  int? postId;
  int? userId;
  String? originType;
  String? postType;
  int? specificPostId;
  int? communityId;
  int? businessId;
  int likes;
  int comments;
  int shares;
  String? createdAt;
  String? updatedAt;
  String? title;
  String? option1;
  int option1Votes;
  String? option2;
  int option2Votes;
  String? option3;
  int option3Votes;
  String? option4;
  int option4Votes;
  String? option5;
  int option5Votes;
  String? personalPhotoUrl;
  String? personalDescription;
  String? resourcePhotoUrl;
  String? resourceDescription;
  String? location;
  double? latitude;
  double? longitude;
  String? businessName;
  bool isPageCreated;
  String? question;
  List<String>? questionPhotos;

  GetUserPostsModel({
    this.postId,
    this.userId,
    this.originType,
    this.postType,
    this.specificPostId,
    this.communityId,
    this.businessId,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.createdAt,
    this.updatedAt,
    this.title,
    this.option1,
    this.option1Votes = 0,
    this.option2,
    this.option2Votes = 0,
    this.option3,
    this.option3Votes = 0,
    this.option4,
    this.option4Votes = 0,
    this.option5,
    this.option5Votes = 0,
    this.personalPhotoUrl,
    this.personalDescription,
    this.resourcePhotoUrl,
    this.resourceDescription,
    this.location,
    this.latitude,
    this.longitude,
    this.businessName,
    this.isPageCreated = false,
    this.question,
    this.questionPhotos,
  });

  factory GetUserPostsModel.fromJson(Map<String, dynamic> json) {
    return GetUserPostsModel(
      postId: json['post_id'] as int?,
      userId: json['user_id'] as int?,
      originType: json['origin_type'] as String?,
      postType: json['post_type'] as String?,
      specificPostId: json['specific_post_id'] as int?,
      communityId: json['community_id'] as int?,
      businessId: json['business_id'] as int?,
      likes: json['likes'] ?? 0,
      comments: json['comments'] ?? 0,
      shares: json['shares'] ?? 0,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      title: json['title'] as String?,
      option1: json['option_1'] as String?,
      option1Votes: json['option_1_votes'] ?? 0,
      option2: json['option_2'] as String?,
      option2Votes: json['option_2_votes'] ?? 0,
      option3: json['option_3'] as String?,
      option3Votes: json['option_3_votes'] ?? 0,
      option4: json['option_4'] as String?,
      option4Votes: json['option_4_votes'] ?? 0,
      option5: json['option_5'] as String?,
      option5Votes: json['option_5_votes'] ?? 0,
      personalPhotoUrl: json['personal_photo_url'] as String?,
      personalDescription: json['personal_description'] as String?,
      resourcePhotoUrl: json['resource_photo_url'] as String?,
      resourceDescription: json['resource_description'] as String?,
      location: json['location'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      businessName: json['business_name'] as String?,
      isPageCreated: json['is_page_created'] ?? false,
      question: json['question'] as String?,
      questionPhotos: (json['question_photos'] as List?)?.map((e) => e as String).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'post_id': postId,
      'user_id': userId,
      'origin_type': originType,
      'post_type': postType,
      'specific_post_id': specificPostId,
      'community_id': communityId,
      'business_id': businessId,
      'likes': likes,
      'comments': comments,
      'shares': shares,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'title': title,
      'option_1': option1,
      'option_1_votes': option1Votes,
      'option_2': option2,
      'option_2_votes': option2Votes,
      'option_3': option3,
      'option_3_votes': option3Votes,
      'option_4': option4,
      'option_4_votes': option4Votes,
      'option_5': option5,
      'option_5_votes': option5Votes,
      'personal_photo_url': personalPhotoUrl,
      'personal_description': personalDescription,
      'resource_photo_url': resourcePhotoUrl,
      'resource_description': resourceDescription,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'business_name': businessName,
      'is_page_created': isPageCreated,
      'question': question,
      'question_photos': questionPhotos,
    };
  }
}