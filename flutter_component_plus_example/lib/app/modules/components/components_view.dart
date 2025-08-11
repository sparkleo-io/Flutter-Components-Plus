import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components_controller.dart';
import '../../../button_examples.dart';

class ComponentsView extends GetView<ComponentsController> {
  const ComponentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Components Plus - Examples'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: const FCPButtonExamples(),
    );
  }
}
