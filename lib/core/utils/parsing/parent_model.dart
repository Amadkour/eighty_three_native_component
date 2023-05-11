abstract class ParentModel {
  ParentModel fromJsonInstance(Map<String, dynamic> json);
}

class ParentDummyModel extends ParentModel {
  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    return this;
  }
}

///    final FromMap converter = FromMap(map: json);
