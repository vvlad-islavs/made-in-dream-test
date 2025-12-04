// ignore_for_file: constant_identifier_names

enum TrailingButtonSizes {
  M(name: 'Большой'), // 54x54
  S(name: 'Средний'), // 48x48
  XS(name: 'Маленький'); // 40x40

  final String name;

  const TrailingButtonSizes({required this.name});
}
