// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_result_header_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersonResultHeaderEntityImpl _$$PersonResultHeaderEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$PersonResultHeaderEntityImpl(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => PersonEntity.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PersonResultHeaderEntityImplToJson(
        _$PersonResultHeaderEntityImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'total': instance.total,
      'data': instance.data,
    };
