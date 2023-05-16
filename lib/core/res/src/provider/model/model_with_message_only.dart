import 'package:eighty_three_native_component/core/utils/parsing/from_map.dart';
import 'package:eighty_three_native_component/core/utils/parsing/parent_model.dart';

class ModelWithMessageOnly extends ParentModel{
  String? message;

  ModelWithMessageOnly({this.message});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter =FromMap(map: json);
    return ModelWithMessageOnly(
      message: converter.convertToString(key: "message")
    );
  }
}
