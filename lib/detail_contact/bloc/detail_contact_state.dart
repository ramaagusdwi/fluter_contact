part of 'detail_contact_bloc.dart';

enum DetailContactStatus { initial, loading, success, failure }

final class DetailContactState extends Equatable {
  const DetailContactState({
    this.status = DetailContactStatus.initial,
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phone = '',
  });

  final DetailContactStatus status;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  DetailContactState copyWith({
    DetailContactStatus Function()? status,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
  }) {
    return DetailContactState(
        status: status != null ? status() : this.status,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phone: phone ?? this.phone);
  }

  @override
  List<Object?> get props => [status, firstName, lastName, phone, email];
}
