// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'person_result_header_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PersonResultHeaderEntity _$PersonResultHeaderEntityFromJson(
    Map<String, dynamic> json) {
  return _PersonResultHeaderEntity.fromJson(json);
}

/// @nodoc
mixin _$PersonResultHeaderEntity {
  String? get status => throw _privateConstructorUsedError;
  int? get code => throw _privateConstructorUsedError;
  int? get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  List<PersonEntity>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PersonResultHeaderEntityCopyWith<PersonResultHeaderEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonResultHeaderEntityCopyWith<$Res> {
  factory $PersonResultHeaderEntityCopyWith(PersonResultHeaderEntity value,
          $Res Function(PersonResultHeaderEntity) then) =
      _$PersonResultHeaderEntityCopyWithImpl<$Res, PersonResultHeaderEntity>;
  @useResult
  $Res call(
      {String? status,
      int? code,
      int? total,
      @JsonKey(name: 'data') List<PersonEntity>? data});
}

/// @nodoc
class _$PersonResultHeaderEntityCopyWithImpl<$Res,
        $Val extends PersonResultHeaderEntity>
    implements $PersonResultHeaderEntityCopyWith<$Res> {
  _$PersonResultHeaderEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? code = freezed,
    Object? total = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<PersonEntity>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PersonResultHeaderEntityImplCopyWith<$Res>
    implements $PersonResultHeaderEntityCopyWith<$Res> {
  factory _$$PersonResultHeaderEntityImplCopyWith(
          _$PersonResultHeaderEntityImpl value,
          $Res Function(_$PersonResultHeaderEntityImpl) then) =
      __$$PersonResultHeaderEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? status,
      int? code,
      int? total,
      @JsonKey(name: 'data') List<PersonEntity>? data});
}

/// @nodoc
class __$$PersonResultHeaderEntityImplCopyWithImpl<$Res>
    extends _$PersonResultHeaderEntityCopyWithImpl<$Res,
        _$PersonResultHeaderEntityImpl>
    implements _$$PersonResultHeaderEntityImplCopyWith<$Res> {
  __$$PersonResultHeaderEntityImplCopyWithImpl(
      _$PersonResultHeaderEntityImpl _value,
      $Res Function(_$PersonResultHeaderEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? code = freezed,
    Object? total = freezed,
    Object? data = freezed,
  }) {
    return _then(_$PersonResultHeaderEntityImpl(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<PersonEntity>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PersonResultHeaderEntityImpl implements _PersonResultHeaderEntity {
  _$PersonResultHeaderEntityImpl(
      {this.status,
      this.code,
      this.total,
      @JsonKey(name: 'data') final List<PersonEntity>? data = const []})
      : _data = data;

  factory _$PersonResultHeaderEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$PersonResultHeaderEntityImplFromJson(json);

  @override
  final String? status;
  @override
  final int? code;
  @override
  final int? total;
  final List<PersonEntity>? _data;
  @override
  @JsonKey(name: 'data')
  List<PersonEntity>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PersonResultHeaderEntity(status: $status, code: $code, total: $total, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonResultHeaderEntityImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.total, total) || other.total == total) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, code, total,
      const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonResultHeaderEntityImplCopyWith<_$PersonResultHeaderEntityImpl>
      get copyWith => __$$PersonResultHeaderEntityImplCopyWithImpl<
          _$PersonResultHeaderEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PersonResultHeaderEntityImplToJson(
      this,
    );
  }
}

abstract class _PersonResultHeaderEntity implements PersonResultHeaderEntity {
  factory _PersonResultHeaderEntity(
          {final String? status,
          final int? code,
          final int? total,
          @JsonKey(name: 'data') final List<PersonEntity>? data}) =
      _$PersonResultHeaderEntityImpl;

  factory _PersonResultHeaderEntity.fromJson(Map<String, dynamic> json) =
      _$PersonResultHeaderEntityImpl.fromJson;

  @override
  String? get status;
  @override
  int? get code;
  @override
  int? get total;
  @override
  @JsonKey(name: 'data')
  List<PersonEntity>? get data;
  @override
  @JsonKey(ignore: true)
  _$$PersonResultHeaderEntityImplCopyWith<_$PersonResultHeaderEntityImpl>
      get copyWith => throw _privateConstructorUsedError;
}
