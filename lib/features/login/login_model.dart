class User {
  String? name;
  String? surname;
  String? email;
  String? branch;
  String? city;
  String? district;
  String? schoolID;
  String? school;

  User({
    this.name,
    this.surname,
    this.email,
    this.branch,
    this.city,
    this.district,
    this.schoolID,
    this.school,
  });

  User copyWith({
    String? name,
    String? surname,
    String? email,
    String? branch,
    String? city,
    String? district,
    String? schoolID,
    String? school,
  }) {
    return User(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      branch: branch ?? this.branch,
      city: city ?? this.city,
      district: district ?? this.district,
      schoolID: schoolID ?? this.schoolID,
      school: school ?? this.school,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'email': email,
      'branch': branch,
      'city': city,
      'district': district,
      'schoolID': schoolID,
      'school': school,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      email: json['email'] as String?,
      branch: json['branch'] as String?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      schoolID: json['schoolID'] as String?,
      school: json['school'] as String?,
    );
  }

  @override
  String toString() =>
      "User(name: $name,surname: $surname,email: $email, branch: $branch,city: $city, district: $district, schoolID: $schoolID, school: $school, )";

  @override
  int get hashCode => Object.hash(name, surname, email, branch,city,district,schoolID,school);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is User &&
              runtimeType == other.runtimeType &&
              name == other.name &&
              surname == other.surname &&
              email == other.email &&
              branch == other.branch &&
              city == other.city &&
              district == other.district &&
              schoolID == other.schoolID &&
              school == other.school;
}
