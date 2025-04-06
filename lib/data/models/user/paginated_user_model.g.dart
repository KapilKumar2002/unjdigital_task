// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedUserModel _$PaginatedUserModelFromJson(Map<String, dynamic> json) =>
    PaginatedUserModel(
      page: (json['page'] as num?)?.toInt(),
      totalPages: (json['total_pages'] as num?)?.toInt(),
      totalUsers: (json['total_users'] as num?)?.toInt(),
      users: (json['users'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PaginatedUserModelToJson(PaginatedUserModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'total_pages': instance.totalPages,
      'total_users': instance.totalUsers,
      'users': instance.users,
    };
