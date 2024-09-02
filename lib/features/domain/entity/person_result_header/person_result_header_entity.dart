import 'package:flutterexamapp/features/domain/entity/person/person_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'person_result_header_entity.g.dart';
part 'person_result_header_entity.freezed.dart';

@freezed
class PersonResultHeaderEntity with _$PersonResultHeaderEntity {
  factory PersonResultHeaderEntity({
    String? status,
    int? code,
    int? total,
    @Default([]) @JsonKey(name: 'data') List<PersonEntity>? data,
  }) = _PersonResultHeaderEntity;

  factory PersonResultHeaderEntity.fromJson(Map<String, dynamic> json) =>
      _$PersonResultHeaderEntityFromJson(json);
}