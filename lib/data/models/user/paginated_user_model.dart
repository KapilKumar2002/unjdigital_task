import 'package:json_annotation/json_annotation.dart';
import 'user_model.dart';

part 'paginated_user_model.g.dart';

@JsonSerializable()
class PaginatedUserModel {
  final int? page;
  @JsonKey(name: 'total_pages')
  final int? totalPages;
  @JsonKey(name: 'total_users')
  final int? totalUsers;
  final List<User> users;

  PaginatedUserModel({
    required this.page,
    required this.totalPages,
    required this.totalUsers,
    required this.users,
  });

  /// Convert JSON to PaginatedUsers object
  factory PaginatedUserModel.fromJson(Map<String, dynamic> json) =>
      _$PaginatedUserModelFromJson(json);

  /// Convert PaginatedUsers object to JSON
  Map<String, dynamic> toJson() => _$PaginatedUserModelToJson(this);
}
