// ignore_for_file: constant_identifier_names

enum ButtonSizes {
  small(name: 'Маленький'),
  medium(name: 'Средний'),
  large(name: 'Большой');

  final String name;

  const ButtonSizes({required this.name});
}
