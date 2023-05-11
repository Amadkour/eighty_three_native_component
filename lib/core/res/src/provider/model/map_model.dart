
import 'package:eighty_three_native_component/core/utils/parsing/parent_model.dart';

class MapModel extends ParentModel {
  final Map<String, dynamic>? map;

  MapModel({this.map});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    return MapModel(map: json);
  }
}
