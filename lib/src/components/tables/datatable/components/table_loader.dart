import 'package:flutter/material.dart';
import '../extensions/table_extensions.dart';

class TableLoader extends StatelessWidget {
  const TableLoader({super.key, required this.isBusy});

  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isBusy,
      child: Container(
        color: context.isDark
            ? Colors.grey.withValues(alpha: 0.05)
            : Colors.grey.withValues(alpha: 0.1),
        child: FCPProgressIndicator(isBusy, loaderType: LoaderType.circular),
      ),
    );
  }
}
