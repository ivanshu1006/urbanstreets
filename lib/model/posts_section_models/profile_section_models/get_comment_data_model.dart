class User {
  final int id;
  final String username;
  final String email;

  User({
    required this.id,
    required this.username,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }
}

class Comment {
  final int id;
  final int postId;
  final int userId;
  final String commentText;
  final DateTime createdAt;
  final User user;

  Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.commentText,
    required this.createdAt,
    required this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      postId: json['post_id'],
      userId: json['user_id'],
      commentText: json['comment_text'],
      createdAt: DateTime.parse(json['createdAt']),
      user: User.fromJson(json['User']),
    );
  }
}
