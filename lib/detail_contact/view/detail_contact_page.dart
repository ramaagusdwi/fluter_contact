import 'package:contacts_repository/contacts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contact/detail_contact/bloc/detail_contact_bloc.dart';
import 'package:flutter_contact/extension/string_extention.dart';
import 'package:flutter_contact/theme/app_text_style.dart';
import 'package:flutter_contact/theme/theme.dart';

class DetailContactPage extends StatefulWidget {
  const DetailContactPage({super.key});

  static Route<void> route(String id) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => DetailContactBloc(
          contactsRepository: context.read<ContactsRepository>(),
        )..add(DetailContactRequest(id)),
        child: const DetailContactPage(),
      ),
    );
  }

  @override
  State<DetailContactPage> createState() => _DetailContactPageState();
}

class _DetailContactPageState extends State<DetailContactPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<DetailContactBloc, DetailContactState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == DetailContactStatus.failure,
      listener: (context, state) {
        if (state.status == DetailContactStatus.failure) {
          var snackBar = SnackBar(
            content: Text(
              'Gagal menampilkan detail kontak!',
              style: AppTextStyle.textWhite14SemiBold,
            ),
            backgroundColor: Colors.redAccent,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: const DetailContactView(),
    );
  }
}

class DetailContactView extends StatelessWidget {
  const DetailContactView({super.key});

  @override
  Widget build(BuildContext context) {

    final state = context.watch<DetailContactBloc>().state;
    return Scaffold(
      appBar: AppBar(
        title: null,
        actions: const [SizedBox(width: 12)],
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                color: FlutterContactsTheme.primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 180.0,
                    ),
                    const SizedBox(width: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.firstName.toCapitalized(),
                          style: AppTextStyle.textWhite28SemiBold,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          state.lastName.toCapitalized(),
                          style: AppTextStyle.textWhite28SemiBold,
                        )
                      ],
                    )
                  ],
                ),
              )),
          const Expanded(flex: 2, child: DetailContactInfo()),
          const Expanded(flex: 1, child: SizedBox.shrink())
        ],
      ),
    );
  }
}

class DetailContactInfo extends StatelessWidget {
  const DetailContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DetailContactBloc>().state;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _PhoneCard(state: state),
          const SizedBox(height: 8),
          _EmailCard(state: state),
          const SizedBox(height: 8),
          _SendContactCard(state: state)
        ],
      ),
    );
  }
}

class _PhoneCard extends StatelessWidget {
  const _PhoneCard({
    super.key,
    required this.state,
  });

  final DetailContactState state;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      child: ListTile(
        minLeadingWidth: 0,
        title: Text(state.phone, style: AppTextStyle.textBody14Bold),
        subtitle: Text(
          'Telephone',
          maxLines: 1,
          style: AppTextStyle.textMuted14SemiBold,
        ),
        leading: Container(
          margin: const EdgeInsets.only(right: 8),
          height: double.infinity,
          child: const Icon(
            Icons.phone,
            color: FlutterContactsTheme.primaryColor,
          ),
        ),
        trailing: const Icon(
          Icons.message,
          color: FlutterContactsTheme.greyColor,
          size: 24.0,
        ),
      ),
    );
  }
}

class _EmailCard extends StatelessWidget {
  const _EmailCard({
    super.key,
    required this.state,
  });

  final DetailContactState state;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      child: ListTile(
        minLeadingWidth: 0,
        title: Text(state.phone, style: AppTextStyle.textBody14Bold),
        subtitle: Text(
          'E-mail',
          maxLines: 1,
          style: AppTextStyle.textMuted14SemiBold,
        ),
        leading: Container(
          margin: const EdgeInsets.only(right: 8),
          height: double.infinity,
          child: const Icon(
            Icons.email,
            color: FlutterContactsTheme.primaryColor,
          ),
        ),
      ),
    );
  }
}

class _SendContactCard extends StatelessWidget {
  const _SendContactCard({
    super.key,
    required this.state,
  });

  final DetailContactState state;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      color: Colors.white,
      child: ListTile(
        minLeadingWidth: 0,
        title: Text('Kirim Kontak', style: AppTextStyle.textBody14Bold),
        subtitle: Text(
          'membagikan',
          maxLines: 1,
          style: AppTextStyle.textMuted14SemiBold,
        ),
        leading: Container(
          margin: const EdgeInsets.only(right: 8),
          height: double.infinity,
          child: const Icon(
            Icons.share,
            color: FlutterContactsTheme.primaryColor,
          ),
        ),
      ),
    );
  }
}
