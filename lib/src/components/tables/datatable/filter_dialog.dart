import 'package:flutter/material.dart';
import 'filter_state.dart';

class FilterDialog extends StatefulWidget {
  final String columnName;
  final String columnType;
  final FilterState? currentFilter;
  final List<dynamic>? uniqueValues;
  final Function(FilterState?) onFilterChanged;

  const FilterDialog({
    Key? key,
    required this.columnName,
    required this.columnType,
    this.currentFilter,
    this.uniqueValues,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late TextEditingController _textController;
  late String _selectedFilterType;
  String _filterValue = '';
  List<dynamic> _selectedOptions = [];
  DateTime? _startDate;
  DateTime? _endDate;
  double? _minValue;
  double? _maxValue;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _selectedFilterType = _determineFilterType();
    _initializeFromCurrentFilter();
  }

  String _determineFilterType() {
    if (widget.currentFilter != null) {
      return widget.currentFilter!.filterType;
    }

    // Auto-detect filter type based on column type or data
    if (widget.columnType.toLowerCase().contains('date')) {
      return 'date';
    } else if (widget.columnType.toLowerCase().contains('number') ||
        widget.columnType.toLowerCase().contains('int') ||
        widget.columnType.toLowerCase().contains('double')) {
      return 'number';
    } else if (widget.uniqueValues != null &&
        widget.uniqueValues!.length <= 20) {
      return 'select';
    } else {
      return 'text';
    }
  }

  void _initializeFromCurrentFilter() {
    if (widget.currentFilter != null) {
      _filterValue = widget.currentFilter!.filterValue;
      _textController.text = _filterValue;
      _startDate = widget.currentFilter!.startDate;
      _endDate = widget.currentFilter!.endDate;
      _minValue = widget.currentFilter!.minValue;
      _maxValue = widget.currentFilter!.maxValue;
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter: ${widget.columnName}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Filter type selector
            DropdownButtonFormField<String>(
              value: _selectedFilterType,
              decoration: const InputDecoration(
                labelText: 'Filter Type',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'text', child: Text('Text Contains')),
                DropdownMenuItem(
                  value: 'select',
                  child: Text('Select Options'),
                ),
                DropdownMenuItem(value: 'number', child: Text('Number Range')),
                DropdownMenuItem(value: 'date', child: Text('Date Range')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedFilterType = value!;
                });
              },
            ),

            const SizedBox(height: 16),

            // Filter content based on type
            _buildFilterContent(),

            const SizedBox(height: 24),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    widget.onFilterChanged(null);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Clear'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _applyFilter,
                  child: const Text('Apply'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterContent() {
    switch (_selectedFilterType) {
      case 'text':
        return TextField(
          controller: _textController,
          decoration: const InputDecoration(
            labelText: 'Filter Value',
            hintText: 'Enter text to filter...',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => _filterValue = value,
        );

      case 'select':
        if (widget.uniqueValues == null || widget.uniqueValues!.isEmpty) {
          return const Text('No unique values available for this column');
        }
        return Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: ListView.builder(
            itemCount: widget.uniqueValues!.length,
            itemBuilder: (context, index) {
              final value = widget.uniqueValues![index];
              final isSelected = _selectedOptions.contains(value);
              return CheckboxListTile(
                title: Text('$value'),
                value: isSelected,
                onChanged: (selected) {
                  setState(() {
                    if (selected == true) {
                      _selectedOptions.add(value);
                    } else {
                      _selectedOptions.remove(value);
                    }
                  });
                },
              );
            },
          ),
        );

      case 'number':
        return Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Minimum Value',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => _minValue = double.tryParse(value),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Maximum Value',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) => _maxValue = double.tryParse(value),
            ),
          ],
        );

      case 'date':
        return Column(
          children: [
            ListTile(
              title: const Text('Start Date'),
              subtitle: Text(
                _startDate?.toString().split(' ')[0] ?? 'Not selected',
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _startDate ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  setState(() {
                    _startDate = date;
                  });
                }
              },
            ),
            ListTile(
              title: const Text('End Date'),
              subtitle: Text(
                _endDate?.toString().split(' ')[0] ?? 'Not selected',
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _endDate ?? DateTime.now(),
                  firstDate: _startDate ?? DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  setState(() {
                    _endDate = date;
                  });
                }
              },
            ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }

  void _applyFilter() {
    FilterState? newFilter;

    if (_selectedFilterType == 'text' && _filterValue.isNotEmpty) {
      newFilter = FilterState(
        columnName: widget.columnName,
        filterType: 'text',
        filterValue: _filterValue,
      );
    } else if (_selectedFilterType == 'select' && _selectedOptions.isNotEmpty) {
      newFilter = FilterState(
        columnName: widget.columnName,
        filterType: 'select',
        filterValue: _selectedOptions.join(','),
        filterOptions: _selectedOptions,
      );
    } else if (_selectedFilterType == 'number' &&
        (_minValue != null || _maxValue != null)) {
      newFilter = FilterState(
        columnName: widget.columnName,
        filterType: 'number',
        minValue: _minValue,
        maxValue: _maxValue,
      );
    } else if (_selectedFilterType == 'date' &&
        (_startDate != null || _endDate != null)) {
      newFilter = FilterState(
        columnName: widget.columnName,
        filterType: 'date',
        startDate: _startDate,
        endDate: _endDate,
      );
    }

    widget.onFilterChanged(newFilter);
    Navigator.of(context).pop();
  }
}
