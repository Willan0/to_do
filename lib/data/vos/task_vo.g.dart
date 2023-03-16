// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskVO _$TaskVOFromJson(Map<String, dynamic> json) => TaskVO(
      json['id'] as int?,
      json['title'] as String?,
      json['note'] as String?,
      json['description'] as String?,
      json['date'] as String?,
      json['time'] as String?,
    );

Map<String, dynamic> _$TaskVOToJson(TaskVO instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'note': instance.note,
      'description': instance.description,
      'date': instance.date,
      'time': instance.time,
    };
