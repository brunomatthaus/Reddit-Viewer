import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reddit/models/model_post.dart';
import 'package:reddit/services/reddit_service.dart';
import '../pages/comentaries.dart';

class FeedPage extends StatefulWidget {

  //Subreddit name is received from search bar
  final String subredditName;

  const FeedPage({super.key, required this.subredditName});
  
  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  final _redditService = RedditService();
  RedditFeed? _redditFeed;

  @override
  void initState(){
    super.initState();

    _fetchRedditPost(widget.subredditName);
  }

  _fetchRedditPost(String subredditName) async{

    try{
      final redditFeed = await _redditService.getFeed(subredditName);
      setState(() {
        _redditFeed = redditFeed;
      }); 
    }
    catch(e){
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(
        title: Text("r/${widget.subredditName}", style: const TextStyle(color: Colors.white, fontSize: 36)),
        backgroundColor: const Color(0xFFFF5700),
        centerTitle: true,
        elevation: 2,
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          _fetchRedditPost(widget.subredditName);
        },
        child:   

          ListView.builder(
            itemCount: _redditFeed?.postsList.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                title: Text(_redditFeed?.postsList[index].postTitle ?? "Loading.."),
                subtitle: Text("Score: ${_redditFeed?.postsList[index].postScore} | Comments: ${_redditFeed?.postsList[index].postNumComments}"),
                onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CommentaryPage(subredditPost: _redditFeed?.postsList[index] ?? RedditPost(subredditName: "subredditName", postId: "postId", postTitle: "postTitle", postScore: 0, postNumComments: 0, postThumbnail: "postThumbnail", postAuthor: "postAuthor", postText: "postText", postURL: "postURL")))
                          );
                },
              ),
            )
          ),

      ),
    );

  }
}  