extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  String toFormatPhoneIndo() => length > 0
      ? '(${substring(0, 3)}) ${substring(3, 6)}-${substring(6, 9)}-${substring(9, 12)}'
      : '';    
}
