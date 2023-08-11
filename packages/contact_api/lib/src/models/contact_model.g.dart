// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactModel _$ContactModelFromJson(Map<String, dynamic> json) => ContactModel(
      firstName: json['firstName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      id: json['id'] as String?,
      lastName: json['lastName'] as String? ?? '',
      work: json['work'] as String? ?? '',
      website: json['website'] as String? ?? '',
      isFavorite: json['isFavorite'] as bool? ?? false,
    );

Map<String, dynamic> _$ContactModelToJson(ContactModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'phone': instance.phone,
      'email': instance.email,
      'work': instance.work,
      'website': instance.website,
      'lastName': instance.lastName,
      'isFavorite': instance.isFavorite,
    };
