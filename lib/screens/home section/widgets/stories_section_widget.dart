// lib/widgets/stories_section.dart


import 'package:flutter/material.dart';
import 'package:frappe_flutter_app/model/chat_section_models/story_model.dart';
import 'package:frappe_flutter_app/providers/story_provider.dart';
import 'package:frappe_flutter_app/screens/home%20section/home_screen.dart';
import 'package:provider/provider.dart';

class StoriesSection extends StatelessWidget {
  const StoriesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storyProvider = Provider.of<StoryProvider>(context);
    final stories = storyProvider.stories;

    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length + 1, // +1 for your story
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildAddStoryItem();
          }
          return _buildStoryItem(stories[index - 1], index == 2); // Second story is active
        },
      ),
    );
  }

  Widget _buildAddStoryItem() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.add_circle, color: Colors.blue, size: 22),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStoryItem(Story story, bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: isActive 
                  ? Border.all(color: Colors.blue, width: 3)
                  : null,
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(story.imageUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }
}