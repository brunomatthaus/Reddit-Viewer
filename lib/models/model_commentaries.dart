class RedditCommentary {

  final String commentAuthor;
  final String commentText;
  final int commentScore;

  RedditCommentary({      
    required this.commentAuthor,
    required this.commentText,
    required this.commentScore
  });   

  factory RedditCommentary.fromJson(Map<String, dynamic> json) {

    String author = json['data']['author'] ?? "null";
    String text = json['data']['body'] ?? "null";
    int score = json['data']['score'] ?? 0;

    return RedditCommentary(  
      commentAuthor: author,
      commentText: text,
      commentScore: score
    );
  }
}

class RedditPostCommentaries {

  List<RedditCommentary> commentaryList = [];

  RedditPostCommentaries({
    required this.commentaryList
  });
      
  RedditPostCommentaries.fromJson(List<dynamic> json) {

    if(json[1]['data']['children'] != null){

      commentaryList=<RedditCommentary>[];
      
      for (var element in (json[1]['data']['children'] as List)) {
        commentaryList.add(RedditCommentary.fromJson(element));
      }
    }
  }
}


