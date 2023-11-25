import 'package:flutter/material.dart';
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => FeedPage(subredditName: redditName))
                                      );
                                  },
                    child: const Text("Search for subreddit"),
                    ),
                ])
      )

    );
  }
}
