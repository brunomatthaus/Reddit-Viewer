import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reddit/models/model_commentaries.dart';
import 'package:reddit/models/model_post.dart';
import 'package:reddit/services/reddit_service.dart';

class CommentaryPage extends StatefulWidget {

  //Subreddit name and post ID is received from feed page
  final RedditPost subredditPost;

  const CommentaryPage({super.key, required this.subredditPost});

  @override
  State<CommentaryPage> createState() => _CommentaryPageState();
}

class _CommentaryPageState extends State<CommentaryPage> {

  final _redditService = RedditService();
  RedditPostCommentaries? _redditPostCommentaries;

  @override
  void initState(){
    super.initState();

    _fetchRedditPostDetails(widget.subredditPost.subredditName, widget.subredditPost.postId);
  }

  _fetchRedditPostDetails(String subredditName, String subredditPostId) async{

    try{
      final redditPostCommentaries = await _redditService.getCommentaries(subredditName, subredditPostId);
      setState(() {
        _redditPostCommentaries = redditPostCommentaries;
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
        title: Text("r/${widget.subredditPost.subredditName}", style: const TextStyle(color: Colors.white, fontSize: 36)),
        backgroundColor: const Color(0xFFFF5700),
        centerTitle: true,
        elevation: 2,
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          _fetchRedditPostDetails(widget.subredditPost.subredditName, widget.subredditPost.postId);
        },
        child:   

          ListView.builder(
            itemCount: _redditPostCommentaries?.commentaryList.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                title: Text(_redditPostCommentaries?.commentaryList[index].commentAuthor ?? "Loading..", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text(_redditPostCommentaries?.commentaryList[index].commentText ?? "Loading.."),
                trailing: Text ("Score: ${_redditPostCommentaries?.commentaryList[index].commentScore.toString()}")
              ),
            )
          ),

      ),
    );

  }
}