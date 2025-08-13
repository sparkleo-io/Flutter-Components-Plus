import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components_controller.dart';
import '../../../button_examples.dart';
import '../../../input_field_examples.dart';
import '../../../card_examples.dart';

class ComponentsView extends GetView<ComponentsController> {
  const ComponentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Components Plus - Examples'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Buttons', icon: Icon(Icons.smart_button)),
              Tab(text: 'Input Fields', icon: Icon(Icons.input)),
              Tab(text: 'Cards', icon: Icon(Icons.credit_card)),
            ],
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
          ),
        ),
        body: const TabBarView(
          children: [
            FCPButtonExamples(),
            FCPInputFieldExamples(),
            CardExamples(),
          ],
        ),
      ),
    );
  }
}
