import 'package:contacts_repository/contacts_repository.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contact/add_contact/bloc/add_contact_bloc.dart';
import 'package:flutter_contact/theme/app_text_style.dart';
import 'package:flutter_contact/theme/color_resource.dart';
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
              current.status == AddContactStatus.success ||
          current.status == AddContactStatus.failure,
      listener: (context, state) {
        if (state.status.isFailure && state.errMessage.isNotEmpty) {
          var snackBar = SnackBar(
            content: Text(
              state.errMessage,
              style: AppTextStyle.textWhite14SemiBold,
            ),
            backgroundColor: Colors.redAccent,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        if (!state.status.isFailure) {
          Navigator.of(context).pop();
        }
      },
      child: const AddContactView(),
    );
  }
}

class AddContactView extends StatelessWidget {
  const AddContactView({super.key});

  @override
  Widget build(BuildContext context) {
    final status = context.select((AddContactBloc bloc) => bloc.state.status);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Membuat kontak baru',
          style: AppTextStyle.textWhite18SemiBold,
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
                  : Text(
                      'Simpan',
                      style: AppTextStyle.textWhite14SemiBold,
                    ),
            ),
          ),
          const SizedBox(width: 12)
        ],
      ),
      body: CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 24),
                _photo(),
                const SizedBox(height: 12),
                const _FirstNameField(),
                const SizedBox(height: 12),
                const _LastNameField(),
                const SizedBox(height: 12),
                const _WorkField(),
                const SizedBox(height: 12),
                const _PhoneField(),
                const SizedBox(height: 12),
                const _EmailField(),
                const SizedBox(height: 12),
                const _WebsiteField(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox _photo() {
    return SizedBox(
      width: 130,
      height: 130,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: FlutterContactsTheme.primaryColor,
          onPressed: () {},
          child: const Icon(
            Icons.photo_camera,
            size: 13,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _FirstNameField extends StatefulWidget {
  const _FirstNameField();

  @override
  State<_FirstNameField> createState() => _FirstNameFieldState();
}

class _FirstNameFieldState extends State<_FirstNameField> {
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
    final state = context.watch<AddContactBloc>().state;

    return TextFormField(
      key: const Key('AddContactView_firstName_textFormField'),
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.always,
      initialValue: state.firstName,
      decoration: InputDecoration(
        icon: Align(
          widthFactor: 0.5,
          heightFactor: 0.5,
          child: Icon(
            Icons.person,
            color: focusNode.hasFocus ? primaryColor : unFocusColor,
          ),
        ),
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
        labelStyle: focusNode.hasFocus
            ? AppTextStyle.textBodyMedium14Purple
            : AppTextStyle.textMuted12,
        hintText: hintText,
        hintStyle: AppTextStyle.textMuted12,
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<AddContactBloc>().add(AddContactFirstNameChanged(value));
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nama depan wajib diisi';
        }

        return null;
      },
    );
  }
}

class _LastNameField extends StatefulWidget {
  const _LastNameField();

  @override
  State<_LastNameField> createState() => _LastNameFieldState();
}

class _LastNameFieldState extends State<_LastNameField> {
  FocusNode focusNode = FocusNode();
  String hintText = 'Nama Belakang';
  TextStyle labelStyle = AppTextStyle.textMuted12;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        hintText = '';
        labelStyle = AppTextStyle.textBodyMedium14Purple;
      } else {
        hintText = 'Nama Belakang';
        labelStyle = AppTextStyle.textMuted12;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AddContactBloc>().state;

    return TextFormField(
      focusNode: focusNode,
      key: const Key('AddContactView_lastName_textFormField'),
      initialValue: state.lastName,
      decoration: InputDecoration(
        icon: Align(
          widthFactor: 0.5,
          heightFactor: 0.5,
          child: Icon(
            Icons.person,
            color: focusNode.hasFocus ? primaryColor : unFocusColor,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: FlutterContactsTheme.primaryColor), //<-- SEE HERE
        ),
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Nama Belakang',
        labelStyle: focusNode.hasFocus
            ? AppTextStyle.textBodyMedium14Purple
            : AppTextStyle.textMuted12,
        hintText: hintText,
        hintStyle: AppTextStyle.textMuted12,
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<AddContactBloc>().add(AddContactLastNameChanged(value));
      },
    );
  }
}

class _WorkField extends StatefulWidget {
  const _WorkField();

  @override
  State<_WorkField> createState() => _WorkFieldState();
}

class _WorkFieldState extends State<_WorkField> {
  FocusNode focusNode = FocusNode();
  String hintText = 'Bekerja';
  TextStyle labelStyle = AppTextStyle.textMuted12;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        hintText = '';
        labelStyle = AppTextStyle.textBodyMedium14Purple;
      } else {
        hintText = 'Bekerja ';
        labelStyle = AppTextStyle.textMuted12;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AddContactBloc>().state;

    return TextFormField(
      focusNode: focusNode,
      key: const Key('AddContactView_work_textFormField'),
      initialValue: state.email,
      decoration: InputDecoration(
        icon: Align(
          widthFactor: 0.5,
          heightFactor: 0.5,
          child: Icon(
            Icons.work,
            color: focusNode.hasFocus ? primaryColor : unFocusColor,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: FlutterContactsTheme.primaryColor), //<-- SEE HERE
        ),
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Bekerja',
        labelStyle: focusNode.hasFocus
            ? AppTextStyle.textBodyMedium14Purple
            : AppTextStyle.textMuted12,
        hintText: hintText,
        hintStyle: AppTextStyle.textMuted12,
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<AddContactBloc>().add(AddContactWorkChanged(value));
      },
    );
  }
}

class _PhoneField extends StatefulWidget {
  const _PhoneField();

  @override
  State<_PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<_PhoneField> {
  FocusNode focusNode = FocusNode();
  String hintText = 'Nomor Telepon';
  TextStyle labelStyle = AppTextStyle.textMuted12;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        hintText = '';
        labelStyle = AppTextStyle.textBodyMedium14Purple;
      } else {
        hintText = 'Nomor Telepon';
        labelStyle = AppTextStyle.textMuted12;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AddContactBloc>().state;

    return TextFormField(
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.always,
      key: const Key('AddContactView_work_textFormField'),
      initialValue: state.phone,
      decoration: InputDecoration(
        icon: Align(
          widthFactor: 0.5,
          heightFactor: 0.5,
          child: Icon(
            Icons.phone,
            color: focusNode.hasFocus ? primaryColor : unFocusColor,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: FlutterContactsTheme.primaryColor), //<-- SEE HERE
        ),
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Nomor Telepon',
        labelStyle: focusNode.hasFocus
            ? AppTextStyle.textBodyMedium14Purple
            : AppTextStyle.textMuted12,
        hintText: hintText,
        hintStyle: AppTextStyle.textMuted12,
      ),
      maxLength: 12,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (value) {
        context.read<AddContactBloc>().add(AddContactPhoneChanged(value));
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Telpon wajib diisi';
        }

        if (value.isNotEmpty && value.length < 12) {
          return 'Telpon minimal 12 digit';
        }

        return null;
      },
    );
  }
}

class _EmailField extends StatefulWidget {
  const _EmailField();

  @override
  State<_EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<_EmailField> {
  FocusNode focusNode = FocusNode();
  String hintText = 'Email';
  TextStyle labelStyle = AppTextStyle.textMuted12;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        hintText = '';
        labelStyle = AppTextStyle.textBodyMedium14Purple;
      } else {
        hintText = 'Email';
        labelStyle = AppTextStyle.textMuted12;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AddContactBloc>().state;

    return TextFormField(
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.always,
      key: const Key('AddContactView_email_textFormField'),
      initialValue: state.email,
      decoration: InputDecoration(
        icon: Align(
          widthFactor: 0.5,
          heightFactor: 0.5,
          child: Icon(
            Icons.email,
            color: focusNode.hasFocus ? primaryColor : unFocusColor,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: FlutterContactsTheme.primaryColor), //<-- SEE HERE
        ),
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Email',
        labelStyle: focusNode.hasFocus
            ? AppTextStyle.textBodyMedium14Purple
            : AppTextStyle.textMuted12,
        hintText: hintText,
        hintStyle: AppTextStyle.textMuted12,
      ),
      onChanged: (value) {
        context.read<AddContactBloc>().add(AddContactEmailChanged(value));
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email wajib diisi';
        }

        bool isvalid = EmailValidator.validate(value);
        if (!isvalid) {
          return " Email tidak valid";
        }
        return null;
      },
    );
  }
}

class _WebsiteField extends StatefulWidget {
  const _WebsiteField();

  @override
  State<_WebsiteField> createState() => _WebsiteFieldState();
}

class _WebsiteFieldState extends State<_WebsiteField> {
  FocusNode focusNode = FocusNode();
  String hintText = 'Website';
  TextStyle labelStyle = AppTextStyle.textMuted12;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        hintText = '';
        labelStyle = AppTextStyle.textBodyMedium14Purple;
      } else {
        hintText = 'Website';
        labelStyle = AppTextStyle.textMuted12;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AddContactBloc>().state;

    return TextFormField(
      focusNode: focusNode,
      key: const Key('AddContactView_website_textFormField'),
      initialValue: state.firstName,
      decoration: InputDecoration(
        icon: Align(
          widthFactor: 0.5,
          heightFactor: 0.5,
          child: Icon(
            Icons.web,
            color: focusNode.hasFocus ? primaryColor : unFocusColor,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
              color: FlutterContactsTheme.primaryColor), //<-- SEE HERE
        ),
        enabled: !state.status.isLoadingOrSuccess,
        labelText: 'Website',
        labelStyle: focusNode.hasFocus
            ? AppTextStyle.textBodyMedium14Purple
            : AppTextStyle.textMuted12,
        hintText: hintText,
        hintStyle: AppTextStyle.textMuted12,
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(50),
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
      ],
      onChanged: (value) {
        context.read<AddContactBloc>().add(AddContactWebsiteChanged(value));
      },
    );
  }
}
