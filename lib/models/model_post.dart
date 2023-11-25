class RedditPost {

  final String subredditName;
  final String postId;
  final String postTitle;
  final int postScore;
  final int postNumComments;
  final String postThumbnail;

  final String postAuthor;
  final String postText;
  final String postURL;

  RedditPost({  
    required this.subredditName,    
    required this.postId,
    required this.postTitle,
    required this.postScore,
    required this.postNumComments,
    required this.postThumbnail,

    required this.postAuthor,
    required this.postText,
    required this.postURL,

  });    

  factory RedditPost.fromJson(Map<String, dynamic> json) {

    return RedditPost(  subredditName: json['data']['subreddit'],
                        postId: json['data']['id'],
                        postTitle: json['data']['title'],
                        postScore: json['data']['score'],
                        postNumComments: json['data']['num_comments'],
                        postThumbnail: json['data']['thumbnail'],
                        
                        postAuthor: json['data']['author'],
                        postText: json['data']['selftext'],
                        postURL: json['data']['url']
                        );

  }
}

class RedditFeed {

  List<RedditPost> postsList = [];

  RedditFeed({
    required this.postsList
  });
      
  RedditFeed.fromJson(Map<String, dynamic> json) {

    if(json['data']['children'] != null){

      postsList=<RedditPost>[];
      for (var element in (json['data']['children'] as List)) {
        postsList.add(RedditPost.fromJson(element));
      }
    }
  }
}


