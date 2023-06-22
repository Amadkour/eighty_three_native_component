import 'package:dio/dio.dart';

FormData createNewFormData(FormData data) {
  final FormData formData = FormData();
  formData.fields.addAll(data.fields);
  //formData.files.addAll(data.files);
  return formData;
}
