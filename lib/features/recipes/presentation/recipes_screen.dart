import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:made_in_dream_test/core/core.dart';

@RoutePage()
class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Welcome', style: context.appPoppinsTextTheme.titleLarge)),
    );
  }
}
