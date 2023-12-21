class ExerciseModel {
  String? bodyPart;
  String? equipment;
  String? gifUrl;
  String? id;
  String? name;
  String? target;
  List<String>? secondaryMuscles;
  List<String>? instructions;

  ExerciseModel(
      {this.bodyPart,
        this.equipment,
        this.gifUrl,
        this.id,
        this.name,
        this.target,
        this.secondaryMuscles,
        this.instructions});

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
    bodyPart : json['bodyPart'],
    equipment : json['equipment'],
    gifUrl : json['gifUrl'],
    id : json['id'],
    name : json['name'],
    target : json['target'],
    secondaryMuscles : json['secondaryMuscles'].cast<String>(),
    instructions : json['instructions'].cast<String>(),
    );
  }
  factory ExerciseModel.fromList(List<dynamic> jsonList) {
    if (jsonList.isNotEmpty) {
      return ExerciseModel.fromJson(jsonList.first);
    } else {
      // Return a default instance or handle it according to your needs
      return ExerciseModel();
    }
  }

  static List<ExerciseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ExerciseModel.fromJson(item)).toList();
  }
}