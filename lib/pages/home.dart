import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reddit/services/reddit_service.dart';
import 'package:reddit/models/model_post.dart';
import '../pages/feed.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
  
class _HomePageState extends State<HomePage>{

  //SearchBar text controller
  late TextEditingController searchController;
  bool disableSearchButton = true;

  @override
  void initState(){
    super.initState();

    //Search bar text field controller
    searchController = TextEditingController();

    // Add listener to check if search bar is empty and disable search button
    searchController.addListener(() {
      disableSearchButton = searchController.text.isEmpty;
      setState(() => disableSearchButton);
    });
  }

  @override
  void dispose(){
    searchController.dispose();
    super.dispose();
  }

  //Search subreddit function
  void _searchSubreddit(String subredditName) async {

    final redditService = RedditService();
    
    try{
      final redditFeed = await redditService.getFeed(subredditName);
      setState(() {
        nextPage(redditFeed);
      });
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to load subreddit!')));
      log(e.toString());
    } 
  }
  
  //Load subreddit feed page if subreddit has at least 1 post
  void nextPage(RedditFeed targetFeed){

    if(targetFeed.postsList.isNotEmpty){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FeedPage(subredditFeed: targetFeed))
      );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('There are no posts in this subreddit!')));
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Reddit", style: TextStyle(color: Colors.white, fontSize: 36)),
        backgroundColor:  const Color(0xFFFF5700),
        centerTitle: true,
        elevation: 2,
      ),

      body: Center(
        child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Container(
                    margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Try searching for 'FullDev'",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: const BorderSide(color: Color(0xFFFF5700))
                        )
                      ),
                    ),
                  ),
                  
                  OutlinedButton(
                    onPressed:  disableSearchButton ? 
                                  null : 
                                  () {
                                      String redditName = searchController.text;
                                      _searchSubreddit(redditName.replaceAll(" ", ""));
                                  },
                    child: const Text("Search for subreddit"),
                    ),
                ])
      )

    );
  }
}

