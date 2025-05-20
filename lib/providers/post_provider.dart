import 'package:flutter/material.dart';
import 'package:frappe_flutter_app/model/posts_section_models/get_user_post_model.dart';
import 'package:frappe_flutter_app/model/posts_section_models/profile_section_models/getUserDataModel.dart';
import 'package:frappe_flutter_app/model/posts_section_models/profile_section_models/get_comment_data_model.dart';
import 'package:frappe_flutter_app/repositories/post_repository.dart';

class PostProvider with ChangeNotifier {
  static final PostProvider _instance = PostProvider._internal();
  factory PostProvider() => _instance;

  final PostRepository _postRepository = PostRepository();

  List<GetUserPostsModel> _posts = [];
  GetUserDataModel? _userProfile;
  List<Comment> _comments = [];

  final Set<int> _likedPosts = {}; 
  final Set<int> _checkedPosts = {}; 
  bool _isLoading = false;

  List<GetUserPostsModel> get posts => _posts;
  GetUserDataModel? get userProfile => _userProfile;
  List<Comment> get comments => _comments;
  bool get isLoading => _isLoading;

  bool _isPostingComment = false;
  bool get isPostingComment => _isPostingComment;
  bool _isFetchingComments = false;
  bool get isFetchingComments => _isFetchingComments;
  bool _isFollowing = false;
  bool get isFollowing => _isFollowing;

  PostProvider._internal();

  Future<void> fetchUserPosts() async {
    _isLoading = true;
    notifyListeners();

    _posts = await _postRepository.getUserPosts();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchUserProfile() async {
    _isLoading = true;
    notifyListeners();

    _userProfile = await _postRepository.getUserProfileData();

    _isLoading = false;
    notifyListeners();
  }

  bool isPostLiked(int postId) {
    return _likedPosts.contains(postId);
  }

  Future<void> checkIfPostLiked(int userId, int postId) async {
    if (_checkedPosts.contains(postId)) return;

    bool liked =
        await _postRepository.checkIfPostLiked(userId: userId, postId: postId);
    if (liked) {
      _likedPosts.add(postId);
    } else {
      _likedPosts.remove(postId);
    }
    _checkedPosts.add(postId);
    notifyListeners();
  }

  Future<void> toggleLikePost(int userId, int postId) async {
    if (_likedPosts.contains(postId)) {
      // Unlike Post
      _likedPosts.remove(postId);
    } else {
      // Like Post
      bool success =
          await _postRepository.likePost(userId: userId, postId: postId);
      if (success) {
        _likedPosts.add(postId);
      }
    }
    notifyListeners();
  }

  Future<void> likePost(int postId, int userId) async {
    bool success =
        await _postRepository.likePost(userId: userId, postId: postId);

    if (success) {
      int index = _posts.indexWhere((post) => post.postId == postId);
      if (index != -1) {
        _posts[index] = GetUserPostsModel(
          postId: _posts[index].postId,
          userId: _posts[index].userId,
          originType: _posts[index].originType,
          postType: _posts[index].postType,
          specificPostId: _posts[index].specificPostId,
          communityId: _posts[index].communityId,
          businessId: _posts[index].businessId,
          likes: _posts[index].likes + 1, // Increment likes
          comments: _posts[index].comments,
          shares: _posts[index].shares,
          createdAt: _posts[index].createdAt,
          updatedAt: _posts[index].updatedAt,
          title: _posts[index].title,
          option1: _posts[index].option1,
          option1Votes: _posts[index].option1Votes,
          option2: _posts[index].option2,
          option2Votes: _posts[index].option2Votes,
          option3: _posts[index].option3,
          option3Votes: _posts[index].option3Votes,
          option4: _posts[index].option4,
          option4Votes: _posts[index].option4Votes,
          option5: _posts[index].option5,
          option5Votes: _posts[index].option5Votes,
          personalPhotoUrl: _posts[index].personalPhotoUrl,
          personalDescription: _posts[index].personalDescription,
          resourcePhotoUrl: _posts[index].resourcePhotoUrl,
          resourceDescription: _posts[index].resourceDescription,
          location: _posts[index].location,
          latitude: _posts[index].latitude,
          longitude: _posts[index].longitude,
          businessName: _posts[index].businessName,
          isPageCreated: _posts[index].isPageCreated,
          question: _posts[index].question,
          questionPhotos: _posts[index].questionPhotos,
        );
        notifyListeners();
      }
    }
  }

  Future<bool> postComment(int userId, int postId, String commentText) async {
    _isPostingComment = true;
    notifyListeners();

    final success = await _postRepository.postComment(
      userId: userId,
      postId: postId,
      commentText: commentText,
    );

    _isPostingComment = false;
    notifyListeners();

    return success;
  }

  // Fetch comments for a specific post
  Future<void> fetchComments(int postId) async {
    _isFetchingComments = true;
    notifyListeners();

    _comments = await _postRepository.fetchComments(postId);

    _isFetchingComments = false;
    notifyListeners();
  }

  Future<void> followUser(int followerId, int followingId) async {
    _isLoading = true;
    notifyListeners();

    final success = await _postRepository.followUser(followerId, followingId);
    if (success) {
      _isFollowing = true;
    }

    _isLoading = false;
    notifyListeners();
  }
}
