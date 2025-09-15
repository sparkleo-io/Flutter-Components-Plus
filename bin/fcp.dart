#!/usr/bin/env dart

import 'dart:io';
import 'package:args/args.dart';
import 'package:flutter_components_plus/src/cli/cli_runner.dart';

/// Main entry point for the FCP CLI tool
void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addFlag('help', abbr: 'h', help: 'Show help information')
    ..addFlag('version', abbr: 'v', help: 'Show version information');

  try {
    final results = parser.parse(arguments);

    if (results['help'] as bool) {
      _showHelp(parser);
      return;
    }

    if (results['version'] as bool) {
      _showVersion();
      return;
    }

    // Handle commands manually
    if (arguments.isEmpty) {
      _showUsage();
      return;
    }

    final cliRunner = CLIRunner();
    await cliRunner.run(arguments);
  } catch (e) {
    stderr.writeln('Error: $e');
    exit(1);
  }
}

/// Show help information
void _showHelp(ArgParser parser) {
  print('''
Flutter Components Plus (FCP) CLI Tool

A command-line tool for managing Flutter Components Plus package features.

USAGE:
    fcp <command> [arguments]

COMMANDS:
    add         Add components or permissions to your Flutter app
    remove      Remove components or permissions from your Flutter app
    list        List available components or permissions
    help        Show this help information
    version     Show version information

EXAMPLES:
    fcp add ble_permissions          # Add BLE permissions to your app
    fcp add permissions              # Add all necessary permissions
    fcp add component chart          # Add chart component
    fcp remove ble_permissions       # Remove BLE permissions
    fcp list components              # List available components
    fcp list permissions             # List available permissions

For more information, visit: https://github.com/your-username/flutter_components_plus
''');
}

/// Show version information
void _showVersion() {
  print('Flutter Components Plus CLI v0.0.3');
}

/// Show usage information
void _showUsage() {
  print('''
Usage: fcp <command> [arguments]

Available commands:
  add         Add components or permissions to your Flutter app
  remove      Remove components or permissions from your Flutter app
  list        List available components or permissions

Examples:
  fcp add ble_permissions          # Add BLE permissions
  fcp add permissions              # Add all permissions
  fcp add component chart          # Add chart component
  fcp remove ble_permissions       # Remove BLE permissions
  fcp list components              # List available components
  fcp list permissions             # List available permissions

Run "fcp help" for more information.
''');
}
