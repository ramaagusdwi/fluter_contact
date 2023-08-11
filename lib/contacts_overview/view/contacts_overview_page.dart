import 'package:contacts_repository/contacts_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contact/add_contact/view/add_contact_page.dart';
import 'package:flutter_contact/theme/theme.dart';
import '../bloc/contacts_overview_bloc.dart';
import '../widgets/widgets.dart';

class ContactsOverviewPage extends StatelessWidget {
  const ContactsOverviewPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => const ContactsOverviewPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactsOverviewBloc(
        contactsRepository: context.read<ContactsRepository>(),
      )..add(const ContactsOverviewSubscriptionRequested()),
      child: const TodosOverviewView(),
    );
  }
}

class TodosOverviewView extends StatelessWidget {
  const TodosOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ContactsOverviewBloc, ContactsOverviewState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == ContactsOverviewStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Terjadi error '),
                    ),
                  );
              }
            },
          ),
          // BlocListener<ContactsOverviewBloc, ContactsOverviewState>(
          //   listenWhen: (previous, current) =>
          //       previous.lastDeletedTodo != current.lastDeletedTodo &&
          //       current.lastDeletedTodo != null,
          //   listener: (context, state) {
          //     final deletedTodo = state.lastDeletedTodo!;
          //     final messenger = ScaffoldMessenger.of(context);
          //   },
          // ),
        ],
        child: BlocBuilder<ContactsOverviewBloc, ContactsOverviewState>(
          builder: (context, state) {
            if (state.contacts.isEmpty) {
              if (state.status == ContactsOverviewStatus.loading) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.status != ContactsOverviewStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                  child: Text(
                    'Belum ada kontak',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              }
            }

            return CupertinoScrollbar(
              child: ListView(
                children: [
                  for (final contact in state.contacts)
                    ContactListTile(
                      contact: contact,
                      onToggleCompleted: (isCompleted) {
                        context.read<ContactsOverviewBloc>().add(
                              ContactsOverviewContactFavoriteToggled(
                                contact: contact,
                                isFavorite: isCompleted,
                              ),
                            );
                      },
                      onDismissed: (_) {
                        // context
                        //     .read<ContactsOverviewBloc>()
                        //     .add(TodosOverviewTodoDeleted(todo));
                      },
                      onTap: () {
                        // Navigator.of(context).push(
                        //   EditTodoPage.route(initialTodo: todo),
                        // );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.of(context).push(
            AddContactPage.route(),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: FlutterContactsTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
    
    );
  }
}
