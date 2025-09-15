import 'dart:io';
import 'package:yaml/yaml.dart';

/// Utility class for file operations
class FileUtils {
  /// Add dependencies to pubspec.yaml
  Future<void> addDependenciesToPubspec(List<String> dependencies) async {
    final pubspecFile = File('pubspec.yaml');

    if (!await pubspecFile.exists()) {
      print('⚠️  pubspec.yaml not found. Skipping dependency addition.');
      return;
    }

    final content = await pubspecFile.readAsString();
    final yaml = loadYaml(content) as Map;

    // Get existing dependencies and create a mutable copy
    final existingDeps = Map<String, dynamic>.from(
      yaml['dependencies'] as Map? ?? {},
    );

    // Add new dependencies
    for (final dep in dependencies) {
      if (!existingDeps.containsKey(dep)) {
        existingDeps[dep] = '^1.0.0'; // Default version
      }
    }

    // Update the YAML content
    final updatedContent = _updatePubspecDependencies(content, existingDeps);
    await pubspecFile.writeAsString(updatedContent);

    print('✅ Dependencies added to pubspec.yaml');
  }

  /// Remove dependencies from pubspec.yaml
  Future<void> removeDependenciesFromPubspec(List<String> dependencies) async {
    final pubspecFile = File('pubspec.yaml');

    if (!await pubspecFile.exists()) {
      print('⚠️  pubspec.yaml not found. Skipping dependency removal.');
      return;
    }

    final content = await pubspecFile.readAsString();
    final yaml = loadYaml(content) as Map;

    // Get existing dependencies and create a mutable copy
    final existingDeps = Map<String, dynamic>.from(
      yaml['dependencies'] as Map? ?? {},
    );

    // Remove specified dependencies
    for (final dep in dependencies) {
      existingDeps.remove(dep);
    }

    // Update the YAML content
    final updatedContent = _updatePubspecDependencies(content, existingDeps);
    await pubspecFile.writeAsString(updatedContent);

    print('✅ Dependencies removed from pubspec.yaml');
  }

  /// Update pubspec.yaml dependencies section
  String _updatePubspecDependencies(String content, Map dependencies) {
    final lines = content.split('\n');
    final result = <String>[];
    bool inDependencies = false;
    bool dependenciesAdded = false;

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i];

      if (line.trim() == 'dependencies:') {
        inDependencies = true;
        result.add(line);
        continue;
      }

      if (inDependencies) {
        if (line.startsWith('  ') && !line.startsWith('    ')) {
          // This is a dependency line
          continue;
        } else if (line.trim().isEmpty ||
            line.startsWith('  ') && line.startsWith('    ')) {
          // This is still in dependencies section
          continue;
        } else {
          // We've reached the end of dependencies section
          inDependencies = false;

          // Add all dependencies
          if (!dependenciesAdded) {
            for (final entry in dependencies.entries) {
              result.add('  ${entry.key}: ${entry.value}');
            }
            dependenciesAdded = true;
          }
        }
      }

      result.add(line);
    }

    // If we were still in dependencies section at the end
    if (inDependencies && !dependenciesAdded) {
      for (final entry in dependencies.entries) {
        result.add('  ${entry.key}: ${entry.value}');
      }
    }

    return result.join('\n');
  }

  /// Check if a file exists
  Future<bool> fileExists(String path) async {
    return await File(path).exists();
  }

  /// Check if a directory exists
  Future<bool> directoryExists(String path) async {
    return await Directory(path).exists();
  }

  /// Create a directory if it doesn't exist
  Future<void> createDirectoryIfNotExists(String path) async {
    final dir = Directory(path);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
  }

  /// Read file content
  Future<String> readFile(String path) async {
    return await File(path).readAsString();
  }

  /// Write file content
  Future<void> writeFile(String path, String content) async {
    await File(path).writeAsString(content);
  }

  /// Copy file
  Future<void> copyFile(String source, String destination) async {
    await File(source).copy(destination);
  }

  /// Delete file
  Future<void> deleteFile(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Delete directory
  Future<void> deleteDirectory(String path) async {
    final dir = Directory(path);
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }

  /// Get file extension
  String getFileExtension(String path) {
    return path.split('.').last;
  }

  /// Get file name without extension
  String getFileNameWithoutExtension(String path) {
    final fileName = path.split('/').last;
    return fileName.split('.').first;
  }

  /// Get directory name
  String getDirectoryName(String path) {
    return path.split('/').last;
  }

  /// Join paths
  String joinPaths(String path1, String path2) {
    return '$path1/$path2';
  }

  /// Check if path is absolute
  bool isAbsolutePath(String path) {
    return path.startsWith('/') || path.contains(':');
  }

  /// Get relative path
  String getRelativePath(String from, String to) {
    final fromParts = from.split('/');
    final toParts = to.split('/');

    int commonLength = 0;
    while (commonLength < fromParts.length &&
        commonLength < toParts.length &&
        fromParts[commonLength] == toParts[commonLength]) {
      commonLength++;
    }

    final result = <String>[];
    for (int i = commonLength; i < fromParts.length - 1; i++) {
      result.add('..');
    }

    for (int i = commonLength; i < toParts.length; i++) {
      result.add(toParts[i]);
    }

    return result.join('/');
  }
}
