import 'package:contacts_repository/contacts_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contact/add_contact/bloc/add_contact_bloc.dart';
import 'package:flutter_contact/theme/theme.dart';

class AddContactPage extends StatelessWidget {
  const AddContactPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => AddContactBloc(
          contactsRepository: context.read<ContactsRepository>(),
        ),
        child: const AddContactPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddContactBloc, AddContactState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == AddContactStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const AddContactView(),
    );
  }
}

class AddContactView extends StatelessWidget {
  const AddContactView({super.key});

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    final status = context.select((AddContactBloc bloc) => bloc.state.status);
    // final isNewTodo = context.select(
    //   (AddContactBloc bloc) => bloc.state.isNewTodo,
    // );
    final theme = Theme.of(context);
    final floatingActionButtonTheme = theme.floatingActionButtonTheme;
    final fabBackgroundColor = floatingActionButtonTheme.backgroundColor ??
        theme.colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Membuat kontak baru',
        ),
        actions: [
          Center(
            child: InkWell(
              onTap: status.isLoadingOrSuccess
                  ? null
                  : () => context
                      .read<AddContactBloc>()
                      .add(const AddContactSubmitted()),
              child: status.isLoadingOrSuccess
                  ? const CupertinoActivityIndicator()
                  : const Text(
                      'Simpan',
                    ),
            ),
          ),
          const SizedBox(width: 12)
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   tooltip: l10n.AddContactSaveButtonTooltip,
      //   shape: const ContinuousRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(32)),
      //   ),
      //   backgroundColor: status.isLoadingOrSuccess
      //       ? fabBackgroundColor.withOpacity(0.5)
      //       : fabBackgroundColor,
      //   onPressed: status.isLoadingOrSuccess
      //       ? null
      //       : () =>
      //           context.read<AddContactBloc>().add(const AddContactSubmitted()),
      //   child: status.isLoadingOrSuccess
      //       ? const CupertinoActivityIndicator()
      //       : const Icon(Icons.check_rounded),
      // ),
      body: const CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [_TitleField(), _LastNameField()],
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleField extends StatefulWidget {
  const _TitleField();

  @override
  State<_TitleField> createState() => _TitleFieldState();
}

class _TitleFieldState extends State<_TitleField> {
  FocusNode focusNode = FocusNode();
  String hintText = 'Nama Depan';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        hintText = '';
      } else {
        hintText = 'Nama Depan';
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    final state = context.watch<AddContactBloc>().state;
    // final hintText = state.initialTodo?.title ?? '';

     
    return TextFormField(
      key: const Key('AddContactView_title_textFormField'),
      focusNode: focusNode,
      initialValue: state.title,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: FlutterContactsTheme.primaryColor), //<-- SEE HERE
        ),
        floatingLabelStyle: MaterialStateTextStyle.resolveWith(
          (Set<MaterialState> states) {
            final Color color = states.contains(MaterialState.error)
                ? Theme.of(context).colorScheme.error
                : FlutterContactsTheme.primaryColor;
            return TextStyle(color: color, letterSpacing: 1.3);
          },
        ),
        labelText: 'Nama Depan',
        hintText: hintText,
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<AddContactBloc>().add(AddContactTitleChanged(value));
      },
    );
  }
}

class _LastNameField extends StatelessWidget {
  const _LastNameField();

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    final state = context.watch<AddContactBloc>().state;
    // final hintText = state.initialTodo?.title ?? '';

    return TextFormField(
      key: const Key('AddContactView_title_textFormField'),
      initialValue: state.title,
      decoration: InputDecoration(
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Nama Belakang',
        hintText: 'Nama Belakang',
      ),
      maxLength: 50,
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<AddContactBloc>().add(AddContactDescriptionChanged(value));
      },
    );
  }
}
