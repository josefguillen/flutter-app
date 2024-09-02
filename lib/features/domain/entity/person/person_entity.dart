import 'package:freezed_annotation/freezed_annotation.dart';

part 'person_entity.g.dart';
part 'person_entity.freezed.dart';

@freezed
class PersonEntity with _$PersonEntity {
  factory PersonEntity({
    int? id,
    String? uuid,
    String? firstname,
    String? lastname,
    String? username,
    String? password,
    String? email,
    String? ip,
    String? macAddress,
    String? website,
    String? image,
  }) = _PersonEntity;

  factory PersonEntity.fromJson(Map<String, dynamic> json) =>
      _$PersonEntityFromJson(json);
}