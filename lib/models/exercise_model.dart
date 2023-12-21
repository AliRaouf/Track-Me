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

  ExerciseModel.fromJson(Map<String, dynamic> json) {
    bodyPart = json['bodyPart'];
    equipment = json['equipment'];
    gifUrl = json['gifUrl'];
    id = json['id'];
    name = json['name'];
    target = json['target'];
    secondaryMuscles = json['secondaryMuscles'].cast<String>();
    instructions = json['instructions'].cast<String>();
  }
}