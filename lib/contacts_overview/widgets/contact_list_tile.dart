import 'package:contacts_repository/contacts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contact/theme/app_text_style.dart';
import 'package:flutter_contact/theme/theme.dart';
import 'package:flutter_contact/extension/string_extention.dart';

class ContactListTile extends StatefulWidget {
  const ContactListTile({
    required this.contact,
    super.key,
    this.onToggleCompleted,
    this.onDismissed,
    this.onTap,
  });

  final ContactModel contact;
  final ValueChanged<bool>? onToggleCompleted;
  final DismissDirectionCallback? onDismissed;
  final VoidCallback? onTap;

  @override
  State<ContactListTile> createState() => _ContactListTileState();
}

class _ContactListTileState extends State<ContactListTile> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final captionColor = theme.textTheme.bodySmall?.color;

    return Dismissible(
      key: Key('todoListTile_dismissible_${widget.contact.id}'),
      onDismissed: widget.onDismissed,
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: theme.colorScheme.error,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Icon(
          Icons.delete,
          color: Color(0xAAFFFFFF),
        ),
      ),
      child: ListTile(
        onTap: widget.onTap,
        title: Text(widget.contact.firstName.toCapitalized(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: !widget.contact.isFavorite
                ? null
                : AppTextStyle.textBody14Bold),
        subtitle: Text(
          widget.contact.phone.toFormatPhoneIndo(),
          maxLines: 1,
          style: AppTextStyle.textMuted14SemiBold,
        ),
        // leading: Checkbox(
        //   shape: const ContinuousRectangleBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(8)),
        //   ),
        //   value: contact.isFavorite,
        //   onChanged: onToggleCompleted == null
        //       ? null
        //       : (value) => onToggleCompleted!(value!),
        // ),
        leading: _NameIcon(
            firstName: widget.contact.firstName,
            backgroundColor: FlutterContactsTheme.primaryColor,
            textColor: FlutterContactsTheme.iconNameTextColor),
        // trailing: onTap == null ? null : const Icon(Icons.chevron_right),
        trailing: InkWell(
          onTap: () {
            setState(() {
              _isFavorite = !_isFavorite;
            });
          },
          child: Icon(
            _isFavorite ? Icons.star : Icons.star_outline,
            color: _isFavorite
                ? FlutterContactsTheme.primaryColor
                : FlutterContactsTheme.greyColor,
            size: 26.0,
          ),
        ),
      ),
    );
  }
}

class _NameIcon extends StatelessWidget {
  final String firstName;
  final Color backgroundColor;
  final Color textColor;

  const _NameIcon({
    required this.firstName,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
  });

  String get firstLetter => this.firstName.substring(0, 1).toUpperCase();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: FittedBox(
        fit: BoxFit.contain,
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: this.backgroundColor,
            border: Border.all(color: Colors.black, width: 0.5),
          ),
          padding: EdgeInsets.all(8.0),
          child:
              Text(this.firstLetter, style: TextStyle(color: this.textColor)),
        ),
      ),
    );
  }
}
