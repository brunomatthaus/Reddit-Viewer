import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/model_post.dart';
import '../models/model_commentaries.dart';

class RedditService 
{

  static const baseURL = 'https://www.reddit.com/r/';

  // Method to get feed from a subreddit in json
  Future<RedditFeed> getFeed(String subredditName) async 
  {
      final response = await http.get(Uri.parse("$baseURL$subredditName.json"));

      if (response.statusCode == 200)
      {
        return RedditFeed.fromJson(jsonDecode(response.body));
      }
      else
      {
        throw Exception('Failed to load subreddit feed');
      }
  }

  // Method to get commentaries from a subreddit post in json
  Future<RedditPostCommentaries> getCommentaries(String subredditName, String postId) async 
  {
      final response = await http.get(Uri.parse("$baseURL$subredditName/$postId.json"));

      if (response.statusCode == 200)
      {
        return RedditPostCommentaries.fromJson(jsonDecode(response.body));
      }
      else
      {
        throw Exception('Failed to load post commentaries');
      }
  }
}

