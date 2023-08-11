import 'package:contacts_repository/contacts_repository.dart';
import 'package:flutter/material.dart';

class ContactListTile extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final captionColor = theme.textTheme.bodySmall?.color;

    return Dismissible(
      key: Key('todoListTile_dismissible_${contact.id}'),
      onDismissed: onDismissed,
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
        onTap: onTap,
        title: Text(
          contact.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: !contact.isFavorite
              ? null
              : TextStyle(
                  color: captionColor,
                  decoration: TextDecoration.lineThrough,
                ),
        ),
        subtitle: Text(
          contact.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: Checkbox(
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          value: contact.isFavorite,
          onChanged: onToggleCompleted == null
              ? null
              : (value) => onToggleCompleted!(value!),
        ),
        trailing: onTap == null ? null : const Icon(Icons.chevron_right),
      ),
    );
  }
}
