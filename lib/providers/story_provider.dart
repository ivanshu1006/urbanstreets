// lib/providers/story_provider.dart


import 'package:flutter/material.dart';
import 'package:frappe_flutter_app/model/chat_section_models/story_model.dart';
import 'package:frappe_flutter_app/screens/home%20section/home_screen.dart';


class StoryProvider with ChangeNotifier {
  final List<Story> _stories = [
    Story(
      id: '1',
      username: 'user1',
      imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
      isViewed: false,
    ),
    Story(
      id: '2',
      username: 'user2',
      imageUrl: 'https://randomuser.me/api/portraits/women/63.jpg',
      isViewed: false,
    ),
    Story(
      id: '3',
      username: 'user3',
      imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
      isViewed: true,
    ),
    Story(
      id: '4',
      username: 'user4',
      imageUrl: 'https://randomuser.me/api/portraits/men/22.jpg',
      isViewed: true,
    ),
    Story(
      id: '5',
      username: 'user5',
      imageUrl: 'https://randomuser.me/api/portraits/women/90.jpg',
      isViewed: true,
    ),
  ];

  List<Story> get stories => [..._stories];

  void viewStory(String storyId) {
    final storyIndex = _stories.indexWhere((story) => story.id == storyId);
    if (storyIndex != -1) {
      final story = _stories[storyIndex];
      _stories[storyIndex] = Story(
        id: story.id,
        username: story.username,
        imageUrl: story.imageUrl,
        isViewed: true,
      );
      notifyListeners();
    }
  }
}