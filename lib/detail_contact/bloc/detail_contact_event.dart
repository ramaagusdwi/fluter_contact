part of 'detail_contact_bloc.dart';

sealed class DetailContactEvent extends Equatable {
  const DetailContactEvent();

  @override
  List<Object> get props => [];
}

final class DetailContactRequest extends DetailContactEvent {
  const DetailContactRequest(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}
