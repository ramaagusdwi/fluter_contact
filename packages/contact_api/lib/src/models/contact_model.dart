import 'package:contact_api/src/models/json_map.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:contact_api/contact_api.dart';
import 'package:uuid/uuid.dart';

part 'contact_model.g.dart';

/// {@template contact_item}
/// A single `contact` item.
///
/// Contains a [firstname], [lastname], [work], [telephone], [email], [situsweb], [share]
/// [sendContact] and [id], in addition to a [isFavorite]
/// flag.
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [ContactModel]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}
@immutable
@JsonSerializable()
class ContactModel extends Equatable {
  /// {@macro contact_item}
  ContactModel({
    required this.firstName,
    required this.email,
    required this.phone,
    String? id,
    this.lastName = '',
    this.work = '',
    this.website = '',
    this.isFavorite = false,
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or not empty',
        ),
        id = id ?? const Uuid().v4();

  /// The unique identifier of the `contact`.
  ///
  /// Cannot be empty.
  final String id;

  /// The title of the `contact`.
  ///
  /// Note that the firstname , phone, email not be empty (mandatory)
  final String firstName;
  final String phone;
  final String email;

  //optional
  //Default empty string
  final String work;
  final String website;
  final String lastName;

  /// Whether the `contact` is completed.
  ///
  /// Defaults to `false`.
  bool isFavorite;

  /// Returns a copy of this `contact` with the given values updated.
  ///
  /// {@macro contact_item}
  ContactModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? website,
    String? work,
    bool? isFavorite,
  }) {
    return ContactModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isFavorite: isFavorite ?? this.isFavorite,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }

  /// Deserializes the given [JsonMap] into a [ContactModel].
  static ContactModel fromJson(JsonMap json) => _$ContactModelFromJson(json);

  /// Converts this [ContactModel] into a [JsonMap].
  JsonMap toJson() => _$ContactModelToJson(this);

  @override
  List<Object> get props => [id, firstName, lastName, phone, isFavorite];
}
