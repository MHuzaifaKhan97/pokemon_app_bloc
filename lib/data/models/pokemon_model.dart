class PokemonModel {
  String? name;
  String? url;
  String? uid;

  PokemonModel({this.name, this.url, this.uid});

  PokemonModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    data['uid'] = uid;
    return data;
  }
}
