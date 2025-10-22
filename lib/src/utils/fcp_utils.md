# FCP Utils

A collection of utility functions and extensions to enhance Flutter development productivity.

## Features

- **String Extensions**: String manipulation and formatting utilities
- **Date Extensions**: Date and time manipulation utilities
- **Widget Extensions**: Widget utility functions and helpers
- **Type Safety**: Null-safe utility functions
- **Performance**: Optimized utility implementations

## String Extensions

### Basic String Operations

#### Capitalize First Letter
```dart
String name = 'john doe';
String capitalized = name.capitalizeFirst();
print(capitalized); // 'John doe'
```

#### Capitalize All Words
```dart
String title = 'hello world';
String capitalized = title.capitalizeWords();
print(capitalized); // 'Hello World'
```

#### Remove Extra Spaces
```dart
String text = '  hello   world  ';
String cleaned = text.removeExtraSpaces();
print(cleaned); // 'hello world'
```

#### Truncate Text
```dart
String longText = 'This is a very long text that needs to be truncated';
String truncated = longText.truncate(20);
print(truncated); // 'This is a very lo...'
```

#### Check if String is Email
```dart
String email = 'user@example.com';
bool isValid = email.isEmail();
print(isValid); // true
```

#### Check if String is URL
```dart
String url = 'https://example.com';
bool isValid = url.isUrl();
print(isValid); // true
```

#### Check if String is Phone Number
```dart
String phone = '+1234567890';
bool isValid = phone.isPhoneNumber();
print(isValid); // true
```

### Advanced String Operations

#### Extract Numbers
```dart
String text = 'Price: \$123.45';
List<double> numbers = text.extractNumbers();
print(numbers); // [123.45]
```

#### Remove Special Characters
```dart
String text = 'Hello@World#123';
String cleaned = text.removeSpecialCharacters();
print(cleaned); // 'HelloWorld123'
```

#### Convert to Slug
```dart
String title = 'Hello World!';
String slug = title.toSlug();
print(slug); // 'hello-world'
```

#### Mask Sensitive Data
```dart
String email = 'user@example.com';
String masked = email.maskEmail();
print(masked); // 'u***@example.com'
```

#### Format Currency
```dart
double amount = 1234.56;
String formatted = amount.formatCurrency();
print(formatted); // '\$1,234.56'
```

## Date Extensions

### Basic Date Operations

#### Format Date
```dart
DateTime date = DateTime.now();
String formatted = date.format('yyyy-MM-dd');
print(formatted); // '2024-01-15'
```

#### Get Relative Time
```dart
DateTime date = DateTime.now().subtract(Duration(hours: 2));
String relative = date.getRelativeTime();
print(relative); // '2 hours ago'
```

#### Check if Date is Today
```dart
DateTime date = DateTime.now();
bool isToday = date.isToday();
print(isToday); // true
```

#### Check if Date is Yesterday
```dart
DateTime date = DateTime.now().subtract(Duration(days: 1));
bool isYesterday = date.isYesterday();
print(isYesterday); // true
```

#### Check if Date is Tomorrow
```dart
DateTime date = DateTime.now().add(Duration(days: 1));
bool isTomorrow = date.isTomorrow();
print(isTomorrow); // true
```

### Advanced Date Operations

#### Get Start of Day
```dart
DateTime date = DateTime(2024, 1, 15, 14, 30, 45);
DateTime startOfDay = date.startOfDay();
print(startOfDay); // 2024-01-15 00:00:00.000
```

#### Get End of Day
```dart
DateTime date = DateTime(2024, 1, 15, 14, 30, 45);
DateTime endOfDay = date.endOfDay();
print(endOfDay); // 2024-01-15 23:59:59.999
```

#### Get Start of Week
```dart
DateTime date = DateTime(2024, 1, 15);
DateTime startOfWeek = date.startOfWeek();
print(startOfWeek); // 2024-01-14 (Sunday)
```

#### Get End of Week
```dart
DateTime date = DateTime(2024, 1, 15);
DateTime endOfWeek = date.endOfWeek();
print(endOfWeek); // 2024-01-20 (Saturday)
```

#### Get Start of Month
```dart
DateTime date = DateTime(2024, 1, 15);
DateTime startOfMonth = date.startOfMonth();
print(startOfMonth); // 2024-01-01 00:00:00.000
```

#### Get End of Month
```dart
DateTime date = DateTime(2024, 1, 15);
DateTime endOfMonth = date.endOfMonth();
print(endOfMonth); // 2024-01-31 23:59:59.999
```

#### Calculate Age
```dart
DateTime birthDate = DateTime(1990, 5, 15);
int age = birthDate.calculateAge();
print(age); // 33
```

#### Get Days Between Dates
```dart
DateTime start = DateTime(2024, 1, 1);
DateTime end = DateTime(2024, 1, 15);
int days = start.getDaysBetween(end);
print(days); // 14
```

## Widget Extensions

### Basic Widget Operations

#### Add Padding
```dart
Widget widget = Text('Hello');
Widget padded = widget.padding(EdgeInsets.all(16));
```

#### Add Margin
```dart
Widget widget = Text('Hello');
Widget margined = widget.margin(EdgeInsets.all(16));
```

#### Add Border
```dart
Widget widget = Text('Hello');
Widget bordered = widget.border(
  Border.all(color: Colors.blue, width: 2),
  borderRadius: BorderRadius.circular(8),
);
```

#### Add Shadow
```dart
Widget widget = Text('Hello');
Widget shadowed = widget.shadow(
  color: Colors.black.withOpacity(0.3),
  blurRadius: 8,
  offset: Offset(0, 4),
);
```

#### Add Background
```dart
Widget widget = Text('Hello');
Widget backgrounded = widget.background(
  Colors.blue,
  borderRadius: BorderRadius.circular(8),
);
```

### Advanced Widget Operations

#### Add Conditional Widget
```dart
Widget widget = Text('Hello');
Widget conditional = widget.conditional(
  condition: true,
  trueWidget: Icon(Icons.check),
  falseWidget: Icon(Icons.close),
);
```

#### Add Loading State
```dart
Widget widget = Text('Hello');
Widget loading = widget.loading(
  isLoading: true,
  loadingWidget: CircularProgressIndicator(),
);
```

#### Add Error State
```dart
Widget widget = Text('Hello');
Widget error = widget.error(
  hasError: true,
  errorWidget: Text('Error occurred'),
);
```

#### Add Empty State
```dart
Widget widget = Text('Hello');
Widget empty = widget.empty(
  isEmpty: true,
  emptyWidget: Text('No data available'),
);
```

#### Add Fade Animation
```dart
Widget widget = Text('Hello');
Widget animated = widget.fadeIn(
  duration: Duration(milliseconds: 300),
  curve: Curves.easeInOut,
);
```

#### Add Slide Animation
```dart
Widget widget = Text('Hello');
Widget animated = widget.slideIn(
  duration: Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  direction: SlideDirection.fromLeft,
);
```

#### Add Scale Animation
```dart
Widget widget = Text('Hello');
Widget animated = widget.scaleIn(
  duration: Duration(milliseconds: 300),
  curve: Curves.easeInOut,
);
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class UtilsExample extends StatefulWidget {
  @override
  _UtilsExampleState createState() => _UtilsExampleState();
}

class _UtilsExampleState extends State<UtilsExample> {
  String _text = 'hello world';
  DateTime _date = DateTime.now();
  bool _isLoading = false;
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Utils Example')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // String Extensions
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('String Extensions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Original: $_text'),
                    SizedBox(height: 8),
                    Text('Capitalized: ${_text.capitalizeFirst()}'),
                    SizedBox(height: 8),
                    Text('All Words: ${_text.capitalizeWords()}'),
                    SizedBox(height: 8),
                    Text('Truncated: ${_text.truncate(10)}'),
                    SizedBox(height: 8),
                    Text('Is Email: ${_text.isEmail()}'),
                    SizedBox(height: 8),
                    Text('Is URL: ${_text.isUrl()}'),
                    SizedBox(height: 8),
                    Text('Is Phone: ${_text.isPhoneNumber()}'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            
            // Date Extensions
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date Extensions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Date: ${_date.format('yyyy-MM-dd HH:mm:ss')}'),
                    SizedBox(height: 8),
                    Text('Relative: ${_date.getRelativeTime()}'),
                    SizedBox(height: 8),
                    Text('Is Today: ${_date.isToday()}'),
                    SizedBox(height: 8),
                    Text('Is Yesterday: ${_date.isYesterday()}'),
                    SizedBox(height: 8),
                    Text('Is Tomorrow: ${_date.isTomorrow()}'),
                    SizedBox(height: 8),
                    Text('Start of Day: ${_date.startOfDay().format('yyyy-MM-dd HH:mm:ss')}'),
                    SizedBox(height: 8),
                    Text('End of Day: ${_date.endOfDay().format('yyyy-MM-dd HH:mm:ss')}'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            
            // Widget Extensions
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Widget Extensions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    
                    // Basic Widget
                    Text('Basic Widget').padding(EdgeInsets.all(8)),
                    SizedBox(height: 8),
                    
                    // Widget with Padding
                    Text('With Padding').padding(EdgeInsets.all(16)).background(Colors.blue[50]),
                    SizedBox(height: 8),
                    
                    // Widget with Border
                    Text('With Border').border(
                      Border.all(color: Colors.blue, width: 2),
                      borderRadius: BorderRadius.circular(8),
                    ).padding(EdgeInsets.all(8)),
                    SizedBox(height: 8),
                    
                    // Widget with Shadow
                    Text('With Shadow').shadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ).padding(EdgeInsets.all(8)),
                    SizedBox(height: 8),
                    
                    // Widget with Background
                    Text('With Background').background(
                      Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ).padding(EdgeInsets.all(8)),
                    SizedBox(height: 8),
                    
                    // Widget with Conditional
                    Text('Conditional Widget').conditional(
                      condition: true,
                      trueWidget: Icon(Icons.check, color: Colors.green),
                      falseWidget: Icon(Icons.close, color: Colors.red),
                    ),
                    SizedBox(height: 8),
                    
                    // Widget with Loading State
                    Text('Loading Widget').loading(
                      isLoading: _isLoading,
                      loadingWidget: CircularProgressIndicator(),
                    ),
                    SizedBox(height: 8),
                    
                    // Widget with Error State
                    Text('Error Widget').error(
                      hasError: _hasError,
                      errorWidget: Text('Error occurred', style: TextStyle(color: Colors.red)),
                    ),
                    SizedBox(height: 8),
                    
                    // Widget with Animation
                    Text('Animated Widget').fadeIn(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            
            // Control Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _text = 'new text';
                        _date = DateTime.now();
                      });
                    },
                    child: Text('Update Data'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isLoading = !_isLoading;
                      });
                    },
                    child: Text('Toggle Loading'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _hasError = !_hasError;
                      });
                    },
                    child: Text('Toggle Error'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

## API Reference

### String Extensions

| Method | Description |
|--------|-------------|
| `capitalizeFirst()` | Capitalize first letter |
| `capitalizeWords()` | Capitalize all words |
| `removeExtraSpaces()` | Remove extra spaces |
| `truncate(int length)` | Truncate text to length |
| `isEmail()` | Check if string is email |
| `isUrl()` | Check if string is URL |
| `isPhoneNumber()` | Check if string is phone number |
| `extractNumbers()` | Extract numbers from string |
| `removeSpecialCharacters()` | Remove special characters |
| `toSlug()` | Convert to slug |
| `maskEmail()` | Mask email address |
| `formatCurrency()` | Format as currency |

### Date Extensions

| Method | Description |
|--------|-------------|
| `format(String pattern)` | Format date with pattern |
| `getRelativeTime()` | Get relative time string |
| `isToday()` | Check if date is today |
| `isYesterday()` | Check if date is yesterday |
| `isTomorrow()` | Check if date is tomorrow |
| `startOfDay()` | Get start of day |
| `endOfDay()` | Get end of day |
| `startOfWeek()` | Get start of week |
| `endOfWeek()` | Get end of week |
| `startOfMonth()` | Get start of month |
| `endOfMonth()` | Get end of month |
| `calculateAge()` | Calculate age |
| `getDaysBetween(DateTime other)` | Get days between dates |

### Widget Extensions

| Method | Description |
|--------|-------------|
| `padding(EdgeInsetsGeometry)` | Add padding |
| `margin(EdgeInsetsGeometry)` | Add margin |
| `border(Border, BorderRadius?)` | Add border |
| `shadow(Color, double, Offset)` | Add shadow |
| `background(Color, BorderRadius?)` | Add background |
| `conditional(bool, Widget, Widget)` | Add conditional widget |
| `loading(bool, Widget)` | Add loading state |
| `error(bool, Widget)` | Add error state |
| `empty(bool, Widget)` | Add empty state |
| `fadeIn(Duration, Curve)` | Add fade animation |
| `slideIn(Duration, Curve, SlideDirection)` | Add slide animation |
| `scaleIn(Duration, Curve)` | Add scale animation |

## Best Practices

1. **Performance**: Use extensions efficiently to avoid unnecessary computations
2. **Type Safety**: Always check for null values when using extensions
3. **Readability**: Use descriptive method names and clear documentation
4. **Testing**: Write unit tests for utility functions
5. **Consistency**: Use consistent naming conventions across extensions
6. **Error Handling**: Implement proper error handling in utility functions
7. **Documentation**: Document complex utility functions with examples

## Accessibility

- All utility functions support proper error handling
- String extensions provide safe text manipulation
- Date extensions handle timezone and locale considerations
- Widget extensions maintain accessibility properties
