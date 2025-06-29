/*
 *  This file is part of the Portfolio project,
 *  licensed under the MIT License.
 *  Copyright (c) 2025 Navid
 *
 *  This file contains code derived from the Flutter samples project,
 *  licensed under the 3-Clause BSD License.
 *  https://github.com/flutter/samples
 *  Copyright (c) 2024 The Flutter team
 *  See THIRD-PARTY-LICENSES.md for the full license text.
 */

// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageApiModel {

 DateTime get dateTime; String get text;
/// Create a copy of MessageApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageApiModelCopyWith<MessageApiModel> get copyWith => _$MessageApiModelCopyWithImpl<MessageApiModel>(this as MessageApiModel, _$identity);

  /// Serializes this MessageApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageApiModel&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateTime,text);

@override
String toString() {
  return 'MessageApiModel(dateTime: $dateTime, text: $text)';
}


}

/// @nodoc
abstract mixin class $MessageApiModelCopyWith<$Res>  {
  factory $MessageApiModelCopyWith(MessageApiModel value, $Res Function(MessageApiModel) _then) = _$MessageApiModelCopyWithImpl;
@useResult
$Res call({
 DateTime dateTime, String text
});




}
/// @nodoc
class _$MessageApiModelCopyWithImpl<$Res>
    implements $MessageApiModelCopyWith<$Res> {
  _$MessageApiModelCopyWithImpl(this._self, this._then);

  final MessageApiModel _self;
  final $Res Function(MessageApiModel) _then;

/// Create a copy of MessageApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateTime = null,Object? text = null,}) {
  return _then(_self.copyWith(
dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _MessageApiModel implements MessageApiModel {
  const _MessageApiModel({required this.dateTime, required this.text});
  factory _MessageApiModel.fromJson(Map<String, dynamic> json) => _$MessageApiModelFromJson(json);

@override final  DateTime dateTime;
@override final  String text;

/// Create a copy of MessageApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageApiModelCopyWith<_MessageApiModel> get copyWith => __$MessageApiModelCopyWithImpl<_MessageApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageApiModel&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.text, text) || other.text == text));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dateTime,text);

@override
String toString() {
  return 'MessageApiModel(dateTime: $dateTime, text: $text)';
}


}

/// @nodoc
abstract mixin class _$MessageApiModelCopyWith<$Res> implements $MessageApiModelCopyWith<$Res> {
  factory _$MessageApiModelCopyWith(_MessageApiModel value, $Res Function(_MessageApiModel) _then) = __$MessageApiModelCopyWithImpl;
@override @useResult
$Res call({
 DateTime dateTime, String text
});




}
/// @nodoc
class __$MessageApiModelCopyWithImpl<$Res>
    implements _$MessageApiModelCopyWith<$Res> {
  __$MessageApiModelCopyWithImpl(this._self, this._then);

  final _MessageApiModel _self;
  final $Res Function(_MessageApiModel) _then;

/// Create a copy of MessageApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateTime = null,Object? text = null,}) {
  return _then(_MessageApiModel(
dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
