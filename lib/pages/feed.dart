import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reddit/models/model_post.dart';
import 'package:reddit/services/reddit_service.dart';
import '../pages/comentaries.dart';

class FeedPage extends StatefulWidget {

  //Subreddit feed is received from search bar
  final RedditFeed subredditFeed;

  const FeedPage({super.key, required this.subredditFeed});
  
  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  final _redditService = RedditService();
  RedditFeed? _redditFeed;

  @override
  void initState(){
    super.initState();

      setState(() {    
        _redditFeed = widget.subredditFeed;
      }); 
  }

  //Gets subreddit feed information
  void _fetchRedditPost(String subredditName) async{

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
        title: Text("r/${widget.subredditFeed.postsList[0].subredditName}", style: const TextStyle(color: Colors.white, fontSize: 36)),
        backgroundColor: const Color(0xFFFF5700),
        centerTitle: true,
        elevation: 2,
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          _fetchRedditPost(widget.subredditFeed.postsList[0].subredditName);
        },
        child:   

          //Feed list of posts
          ListView.builder(
            itemCount: _redditFeed?.postsList.length,
            itemBuilder: (context, index) => Card(
              
              child: ListTile(
                title: Text(_redditFeed?.postsList[index].postTitle ?? "Loading.."),
                subtitle: Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  const Icon(Icons.favorite, color: Colors.red),
                                  Text(' ${_redditFeed?.postsList[index].postScore} | '),
                                  const Icon(Icons.comment, color: Colors.grey),
                                  Text(' ${_redditFeed?.postsList[index].postNumComments}'),
                                ],
                            ),
                trailing: Image.network(_redditFeed?.postsList[index].postThumbnail ?? "",
                                        height: 70.0,
                                        width: 70.0,
                                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                          return const Text('');
                                        },
                          ),
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