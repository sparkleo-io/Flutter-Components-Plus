// ignore_for_file: avoid_print
import 'commands/add_command.dart';
import 'commands/remove_command.dart';
import 'commands/list_command.dart';

/// Main CLI runner that handles command routing
class CLIRunner {
  final AddCommand _addCommand = AddCommand();
  final RemoveCommand _removeCommand = RemoveCommand();
  final ListCommand _listCommand = ListCommand();

  /// Run the CLI with arguments
  Future<void> run(List<String> arguments) async {
    if (arguments.isEmpty) {
      _showUsage();
      return;
    }

    final command = arguments[0];
    final subArguments = arguments.skip(1).toList();

    switch (command) {
      case 'add':
        await _addCommand.run(subArguments);
        break;
      case 'remove':
        await _removeCommand.run(subArguments);
        break;
      case 'list':
        await _listCommand.run(subArguments);
        break;
      default:
        _showUsage();
    }
  }

  /// Show usage information
  void _showUsage() {
    print('''
Usage: fcp <command> [arguments]

Available commands:
  add         Add components or permissions to your Flutter app
  remove      Remove components or permissions from your Flutter app
  list        List available components or permissions

Run "fcp help" for more information.
''');
  }
}
