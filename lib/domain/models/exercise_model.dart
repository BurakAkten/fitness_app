class ExerciseModel {
  int? id;
  final String? name;
  final int? setCount;
  final int? setRepeat;
  final double? weight;
  final int? weightCount;

  ExerciseModel({this.id, this.name, this.setCount, this.setRepeat, this.weight, this.weightCount});

  factory ExerciseModel.fromJson(Map<String, dynamic> data) => ExerciseModel(
        id: data["ID"],
        name: data["NAME"],
        setCount: data["SET_COUNT"],
        setRepeat: data["SET_REPEAT"],
        weight: data["WEIGHT"] != null ? double.tryParse(data["WEIGHT"].toString()) : null,
        weightCount: data["WEIGHT_COUNT"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "NAME": name,
        "SET_COUNT": setCount,
        "SET_REPEAT": setRepeat,
        "WEIGHT": weight,
        "WEIGHT_COUNT": weightCount,
      };

  static List<ExerciseModel> listFromJson(List<dynamic>? json) {
    return json == null ? <ExerciseModel>[] : json.map((value) => ExerciseModel.fromJson(value)).toList();
  }

  @override
  bool operator ==(Object other) {
    if (other is ExerciseModel) {
      return this.weight == other.weight &&
          this.weightCount == other.weightCount &&
          this.setRepeat == other.setRepeat &&
          this.setCount == other.setCount &&
          this.name == other.name;
    }
    return false;
  }
}
