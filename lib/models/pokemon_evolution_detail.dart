class PokemonEvolutionDetail {
  int id;
  Species species;

  PokemonEvolutionDetail({this.id, this.species});

  PokemonEvolutionDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    species =
        json['species'] != null ? new Species.fromJson(json['species']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.species != null) {
      data['species'] = this.species.toJson();
    }
    return data;
  }
}

class Species {
  String name;
  String url;

  Species({this.name, this.url});

  Species.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
