import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Company {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String catchPhrase;

  @HiveField(2)
  final String bs;

  Company({required this.name, required this.catchPhrase, required this.bs});

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
