class Pokemon {
  String name;
  int pokedexNumber;
  String genIntroduced;
  String primaryColor;
  String shape;
  String typing;
  int height;
  int weight;
  int hp;
  int attack;
  int defense;
  int speed;
  int baseExperience;
  bool canEvolve;
  String raridade;

  Pokemon(
      this.name,
      this.pokedexNumber,
      this.genIntroduced,
      this.primaryColor,
      this.shape,
      this.typing,
      this.height,
      this.weight,
      this.hp,
      this.attack,
      this.defense,
      this.speed,
      this.baseExperience,
      this.canEvolve,
      this.raridade);

  Pokemon.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        pokedexNumber = json['pokedex_number'],
        genIntroduced = json['gen_introduced'],
        primaryColor = json['primary_color'],
        shape = json['shape'],
        typing = json['typing'],
        height = json['height'],
        weight = json['weight'],
        hp = json['hp'],
        attack = json['attack'],
        defense = json['defense'],
        speed = json['speed'],
        baseExperience = json['base_experience'],
        canEvolve = json['can_evolve'],
        raridade = json['raridade'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'pokedex_number': pokedexNumber,
        'gen_introduced': genIntroduced,
        'primary_color': primaryColor,
        'shape': shape,
        'typing': typing,
        'height': height,
        'weight': weight,
        'hp': hp,
        'attack': attack,
        'defense': defense,
        'speed': speed,
        'base_experience': baseExperience,
        'can_evolve': canEvolve,
        'raridade': raridade,
      };
}
