

class Media {
  final String id;
  final String url;

  Media({
    required this.id,
    required this.url,
  });

  // Create a Media object from JSON
  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'],
      url: json['url'],
    );
  }

  // Convert Media object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
    };
  }
}
