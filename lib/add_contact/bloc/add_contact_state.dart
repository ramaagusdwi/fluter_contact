part of 'add_contact_bloc.dart';

enum AddContactStatus { initial, loading, success, failure }

extension AddContactStatusX on AddContactStatus {
  bool get isLoadingOrSuccess => [
        AddContactStatus.loading,
        AddContactStatus.success,
      ].contains(this);
  bool get isFailure => [
        AddContactStatus.failure,
      ].contains(this);
}

final class AddContactState extends Equatable {
  const AddContactState({
    this.status = AddContactStatus.initial,
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phone = '',
    this.errMessage = '',
    this.work = '',
    this.website = '',
  });

  final AddContactStatus status;
  final String firstName;

  final String email;
  final String phone;
  final String errMessage;

  //optional
  final String work;
  final String lastName;
  final String website;

  AddContactState copyWith({
    AddContactStatus? status,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? errorMessage,
    String? work,
    String? website,
  }) {
    return AddContactState(
      status: status ?? this.status,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      errMessage: errorMessage ?? this.errMessage,
        work: work ?? this.work,
        website: website ?? this.website
    );
  }

  @override
  List<Object?> get props =>
      [status, firstName, lastName, email, phone, errMessage, work, website];
}
