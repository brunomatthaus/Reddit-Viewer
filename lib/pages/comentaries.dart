import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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

  //Gets post commentaries information
  void _fetchRedditPostDetails(String subredditName, String subredditPostId) async{

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

  void _launchURL(String url) async{

    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch external link');
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

      body: SafeArea(    
        top: true,

          child: SingleChildScrollView(
      
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //Post details

                    //Author
                    Text(widget.subredditPost.postAuthor, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.justify),
                    const SizedBox(height: 8),

                    //Title
                    Text(widget.subredditPost.postTitle, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.justify),
                    const SizedBox(height: 8),

                    //Text
                    Text(widget.subredditPost.postText, style: const TextStyle(color: Colors.black, fontSize: 16), textAlign: TextAlign.justify),
                    const SizedBox(height: 8),

                    //Image
                    Image.network(widget.subredditPost.postURL,
                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                    return const Text("");
                                  },
                    ),

                    //Button to external link
                    OutlinedButton(
                      onPressed:  () {_launchURL(widget.subredditPost.postURL);},
                      child: const Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Icon(Icons.link, color: Colors.lightBlue),
                                    Text("  External Link"),
                                  ],
                      ), 
                    ),

                    //Score
                    Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Icon(Icons.favorite, color: Colors.red),
                            Text(widget.subredditPost.postScore.toString()),
                          ],
                        ), 
                    const SizedBox(height: 16),
                    
/*
                    //Commentary list
                    Expanded(
                      child:
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _redditPostCommentaries?.commentaryList.length,
                        itemBuilder: (context, index) => Card(
                          child: ListTile(
                            title: Text(_redditPostCommentaries?.commentaryList[index].commentAuthor ?? "Loading..", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            subtitle: Text(_redditPostCommentaries?.commentaryList[index].commentText ?? "Loading.."),
                            trailing: Wrap(
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            const Icon(Icons.favorite, color: Colors.red),
                                            Text('${_redditPostCommentaries?.commentaryList[index].commentScore.toString()}'),
                                          ],
                                      ) 
                          )
                        )
                      )
                    ),*/
                  ]
                )
              ),
            )            
          )

          
      );

  }
}