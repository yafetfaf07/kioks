class Rating {
  final String id;
  final String mid;
  final String uid;
  final String content;
  final int rating;

  Rating({
    required this.id,
    required this.mid,
    required this.uid,
    required this.content,
    required this.rating,
  });

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "mid": mid,
      "uid": uid,
      "content": content,
      "rating": rating,
    };
  }

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      id: json['_id'],
      mid: json['mid'],
      uid: json['uid'],
      content: json['content'],
      rating: json['rating'],
    );
  }
}
