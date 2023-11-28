class User {
  String? name;
  String? surname;
  String? branch;
  String? school;

  User({
    this.name,
    this.surname,
    this.branch,
    this.school,
  });

  User copyWith({
    String? name,
    String? surname,
    String? branch,
    String? school,
  }) {
    return User(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      branch: branch ?? this.branch,
      school: school ?? this.school,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'branch': branch,
      'school': school,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      branch: json['branch'] as String?,
      school: json['school'] as String?,
    );
  }

  @override
  String toString() =>
      "User(name: $name,surname: $surname,branch: $branch,school: $school)";

  @override
  int get hashCode => Object.hash(name, surname, branch, school);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is User &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              surname == other.surname &&
              branch == other.branch &&
              school == other.school;
}
