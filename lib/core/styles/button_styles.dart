// ignore_for_file: constant_identifier_names

enum ButtonStyles {
  filled(name: 'Заполненный'),
  outlined(name: 'Рамка и текст'),
  textOnly(name: 'Только текст');

  final String name;

  const ButtonStyles({required this.name});
}
