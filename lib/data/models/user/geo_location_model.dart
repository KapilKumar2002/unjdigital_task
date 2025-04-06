import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'geo_location_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class GeoLocation {
  @HiveField(0)
  final String latitude;

  @HiveField(1)
  final String longitude;

  GeoLocation({required this.latitude, required this.longitude});

  factory GeoLocation.fromJson(Map<String, dynamic> json) =>
      _$GeoLocationFromJson(json);

  Map<String, dynamic> toJson() => _$GeoLocationToJson(this);
}
