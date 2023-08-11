part of 'add_contact_bloc.dart';

enum AddContactStatus { initial, loading, success, failure }

extension AddContactStatusX on AddContactStatus {
  bool get isLoadingOrSuccess => [
        AddContactStatus.loading,
        AddContactStatus.success,
      ].contains(this);
}

final class AddContactState extends Equatable {
  const AddContactState({
    this.status = AddContactStatus.initial,
    this.title = '',
    this.description = '',
  });

  final AddContactStatus status;
  final String title;
  final String description;

  AddContactState copyWith({
    AddContactStatus? status,
    String? title,
    String? description,
  }) {
    return AddContactState(
      status: status ?? this.status,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [status, title, description];
}
