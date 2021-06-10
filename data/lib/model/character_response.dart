class CharacterResponse {
  late final String name;
  late final String image;

  CharacterResponse({
    required this.name,
    required this.image,
  });

  CharacterResponse.fromJson(Map<String, dynamic> json) {
    name = json['character']['name']['full'];
    image = json['character']['image']['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
