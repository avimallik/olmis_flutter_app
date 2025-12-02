class TypeOfPost {
  final int id;
  final String postType;

  TypeOfPost({
    required this.id,
    required this.postType,
  });

  factory TypeOfPost.fromJson(Map<String, dynamic> json) {
    return TypeOfPost(
      id: json['id'],
      postType: json['post_type'],
    );
  }
}
