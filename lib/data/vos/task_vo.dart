import 'package:json_annotation/json_annotation.dart';
part 'task_vo.g.dart';

@JsonSerializable()
class TaskVO{
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'note')
  String? note;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'date')
  String? date;

  @JsonKey(name: 'time')
  String? time;

  TaskVO(this.id, this.title, this.note, this.description,this.date,this.time);

  factory TaskVO.fromJson(Map<String,dynamic> json)=> _$TaskVOFromJson(json);

  Map<String,dynamic> toJson ()=> _$TaskVOToJson(this);
}