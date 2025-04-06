import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'company_model.dart';
import 'geo_location_model.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class User {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final String? address;

  @HiveField(5)
  final Company? company;

  @HiveField(6)
  final String? website;

  @HiveField(7)
  final String? username;

  @HiveField(8)
  final GeoLocation? geoLocation;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.address,
    this.company,
    this.website,
    this.username,
    this.geoLocation,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// **Merging API data with existing cache**
  User merge(User updatedUser) {
    return User(
      id: id,
      name: name,
      email: email,
      phone: phone,
      address: updatedUser.address ?? address,
      company: updatedUser.company ?? company,
      website: updatedUser.website ?? website,
      username: updatedUser.username ?? username,
      geoLocation: updatedUser.geoLocation ?? geoLocation,
    );
  }

  /// ✅ CopyWith method for updating fields immutably
  User copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    Company? company,
    String? website,
    String? username,
    GeoLocation? geoLocation,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      company: company ?? this.company,
      website: website ?? this.website,
      username: username ?? this.username,
      geoLocation: geoLocation ?? this.geoLocation,
    );
  }
}
