# FCPCustomInputField Component

A highly customizable input field component with validation, styling, and interactive features.

## Features

- **Multiple Types**: Text, email, password, number, phone, and more
- **Validation**: Built-in validation with custom error messages
- **Styling**: Full control over colors, borders, and typography
- **Icons**: Support for prefix and suffix icons
- **Animations**: Smooth focus animations and transitions
- **Accessibility**: Screen reader support and keyboard navigation
- **Responsive**: Automatic sizing and responsive design

## Basic Usage

### Simple Text Input
```dart
FCPCustomInputField(
  label: 'Name',
  hint: 'Enter your name',
  onChanged: (value) {
    print('Name: $value');
  },
)
```

### Email Input with Validation
```dart
FCPCustomInputField(
  label: 'Email',
  hint: 'Enter your email',
  type: FCPInputType.email,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  },
  onChanged: (value) {
    print('Email: $value');
  },
)
```

### Password Input
```dart
FCPCustomInputField(
  label: 'Password',
  hint: 'Enter your password',
  type: FCPInputType.password,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  },
  onChanged: (value) {
    print('Password: $value');
  },
)
```

## Advanced Usage

### Input with Icons
```dart
FCPCustomInputField(
  label: 'Search',
  hint: 'Search for products',
  prefixIcon: Icons.search,
  suffixIcon: Icons.clear,
  onSuffixIconTap: () {
    // Clear input
  },
  onChanged: (value) {
    print('Search: $value');
  },
)
```

### Input with Custom Styling
```dart
FCPCustomInputField(
  label: 'Custom Input',
  hint: 'Enter text',
  style: FCPInputFieldStyle(
    backgroundColor: Colors.grey[100],
    borderColor: Colors.blue,
    borderWidth: 2,
    borderRadius: 12,
    labelColor: Colors.blue,
    hintColor: Colors.grey[600],
    textColor: Colors.black,
    errorColor: Colors.red,
  ),
  onChanged: (value) {
    print('Custom: $value');
  },
)
```

### Input with Helper Text
```dart
FCPCustomInputField(
  label: 'Username',
  hint: 'Enter your username',
  helperText: 'Username must be unique and contain only letters and numbers',
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
      return 'Username can only contain letters and numbers';
    }
    return null;
  },
  onChanged: (value) {
    print('Username: $value');
  },
)
```

### Input with Character Counter
```dart
FCPCustomInputField(
  label: 'Description',
  hint: 'Enter description',
  maxLength: 200,
  showCharacterCounter: true,
  onChanged: (value) {
    print('Description: $value');
  },
)
```

### Input with Custom Validation
```dart
FCPCustomInputField(
  label: 'Phone Number',
  hint: 'Enter phone number',
  type: FCPInputType.phone,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^\+?[\d\s\-\(\)]+$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  },
  onChanged: (value) {
    print('Phone: $value');
  },
)
```

### Input with Loading State
```dart
FCPCustomInputField(
  label: 'Email',
  hint: 'Enter your email',
  type: FCPInputType.email,
  loading: true,
  loadingWidget: CircularProgressIndicator(),
  onChanged: (value) {
    print('Email: $value');
  },
)
```

### Input with Custom Error Widget
```dart
FCPCustomInputField(
  label: 'Password',
  hint: 'Enter your password',
  type: FCPInputType.password,
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    return null;
  },
  errorWidget: (error) => Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.red[50],
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: Colors.red),
    ),
    child: Row(
      children: [
        Icon(Icons.error, color: Colors.red, size: 16),
        SizedBox(width: 8),
        Expanded(child: Text(error, style: TextStyle(color: Colors.red))),
      ],
    ),
  ),
  onChanged: (value) {
    print('Password: $value');
  },
)
```

## Input Types

### Text Input
```dart
FCPCustomInputField(
  label: 'Text Input',
  type: FCPInputType.text,
  onChanged: (value) => print('Text: $value'),
)
```

### Email Input
```dart
FCPCustomInputField(
  label: 'Email',
  type: FCPInputType.email,
  onChanged: (value) => print('Email: $value'),
)
```

### Password Input
```dart
FCPCustomInputField(
  label: 'Password',
  type: FCPInputType.password,
  onChanged: (value) => print('Password: $value'),
)
```

### Number Input
```dart
FCPCustomInputField(
  label: 'Age',
  type: FCPInputType.number,
  onChanged: (value) => print('Age: $value'),
)
```

### Phone Input
```dart
FCPCustomInputField(
  label: 'Phone',
  type: FCPInputType.phone,
  onChanged: (value) => print('Phone: $value'),
)
```

### URL Input
```dart
FCPCustomInputField(
  label: 'Website',
  type: FCPInputType.url,
  onChanged: (value) => print('URL: $value'),
)
```

### Multiline Input
```dart
FCPCustomInputField(
  label: 'Message',
  type: FCPInputType.multiline,
  maxLines: 5,
  onChanged: (value) => print('Message: $value'),
)
```

## Complete Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

class InputFieldExample extends StatefulWidget {
  @override
  _InputFieldExampleState createState() => _InputFieldExampleState();
}

class _InputFieldExampleState extends State<InputFieldExample> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Input Field Examples')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Basic Text Input
              FCPCustomInputField(
                label: 'Full Name',
                hint: 'Enter your full name',
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                onChanged: (value) => print('Name: $value'),
              ),
              SizedBox(height: 16),
              
              // Email Input
              FCPCustomInputField(
                label: 'Email Address',
                hint: 'Enter your email',
                type: FCPInputType.email,
                controller: _emailController,
                prefixIcon: Icons.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onChanged: (value) => print('Email: $value'),
              ),
              SizedBox(height: 16),
              
              // Password Input
              FCPCustomInputField(
                label: 'Password',
                hint: 'Enter your password',
                type: FCPInputType.password,
                controller: _passwordController,
                prefixIcon: Icons.lock,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
                onChanged: (value) => print('Password: $value'),
              ),
              SizedBox(height: 16),
              
              // Phone Input
              FCPCustomInputField(
                label: 'Phone Number',
                hint: 'Enter your phone number',
                type: FCPInputType.phone,
                controller: _phoneController,
                prefixIcon: Icons.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number is required';
                  }
                  if (!RegExp(r'^\+?[\d\s\-\(\)]+$').hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
                onChanged: (value) => print('Phone: $value'),
              ),
              SizedBox(height: 16),
              
              // Multiline Input
              FCPCustomInputField(
                label: 'Message',
                hint: 'Enter your message',
                type: FCPInputType.multiline,
                controller: _messageController,
                maxLines: 5,
                maxLength: 500,
                showCharacterCounter: true,
                helperText: 'Maximum 500 characters',
                onChanged: (value) => print('Message: $value'),
              ),
              SizedBox(height: 16),
              
              // Custom Styled Input
              FCPCustomInputField(
                label: 'Custom Input',
                hint: 'Enter text',
                style: FCPInputFieldStyle(
                  backgroundColor: Colors.blue[50],
                  borderColor: Colors.blue,
                  borderWidth: 2,
                  borderRadius: 12,
                  labelColor: Colors.blue,
                  hintColor: Colors.blue[600],
                  textColor: Colors.blue[900],
                ),
                onChanged: (value) => print('Custom: $value'),
              ),
              SizedBox(height: 16),
              
              // Input with Loading State
              FCPCustomInputField(
                label: 'Loading Input',
                hint: 'This input is loading',
                loading: true,
                loadingWidget: CircularProgressIndicator(),
                onChanged: (value) => print('Loading: $value'),
              ),
              SizedBox(height: 16),
              
              // Input with Helper Text
              FCPCustomInputField(
                label: 'Username',
                hint: 'Enter your username',
                helperText: 'Username must be unique and contain only letters and numbers',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is required';
                  }
                  if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                    return 'Username can only contain letters and numbers';
                  }
                  return null;
                },
                onChanged: (value) => print('Username: $value'),
              ),
              SizedBox(height: 24),
              
              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Form submitted successfully!')),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## API Reference

### FCPCustomInputField Properties

| Property | Type | Description |
|----------|--------|-------------|
| `label` | `String?` | Field label |
| `hint` | `String?` | Hint text |
| `controller` | `TextEditingController?` | Text controller |
| `type` | `FCPInputType?` | Input type |
| `validator` | `String? Function(String?)?` | Validation function |
| `onChanged` | `Function(String)?` | Change callback |
| `onSubmitted` | `Function(String)?` | Submit callback |
| `onTap` | `VoidCallback?` | Tap callback |
| `prefixIcon` | `IconData?` | Prefix icon |
| `suffixIcon` | `IconData?` | Suffix icon |
| `onSuffixIconTap` | `VoidCallback?` | Suffix icon tap callback |
| `enabled` | `bool` | Enabled state |
| `readOnly` | `bool` | Read-only state |
| `obscureText` | `bool` | Obscure text |
| `maxLines` | `int?` | Maximum lines |
| `maxLength` | `int?` | Maximum length |
| `showCharacterCounter` | `bool` | Show character counter |
| `helperText` | `String?` | Helper text |
| `errorText` | `String?` | Error text |
| `style` | `FCPInputFieldStyle?` | Custom style |
| `loading` | `bool` | Loading state |
| `loadingWidget` | `Widget?` | Loading widget |
| `errorWidget` | `Widget Function(String)?` | Custom error widget |

### FCPInputType

| Type | Description |
|------|-------------|
| `text` | Text input |
| `email` | Email input |
| `password` | Password input |
| `number` | Number input |
| `phone` | Phone input |
| `url` | URL input |
| `multiline` | Multiline input |

### FCPInputFieldStyle Properties

| Property | Type | Description |
|----------|--------|-------------|
| `backgroundColor` | `Color?` | Background color |
| `borderColor` | `Color?` | Border color |
| `borderWidth` | `double?` | Border width |
| `borderRadius` | `double?` | Border radius |
| `labelColor` | `Color?` | Label color |
| `hintColor` | `Color?` | Hint color |
| `textColor` | `Color?` | Text color |
| `errorColor` | `Color?` | Error color |
| `helperColor` | `Color?` | Helper text color |
| `iconColor` | `Color?` | Icon color |
| `labelStyle` | `TextStyle?` | Label text style |
| `hintStyle` | `TextStyle?` | Hint text style |
| `textStyle` | `TextStyle?` | Text style |
| `errorStyle` | `TextStyle?` | Error text style |
| `helperStyle` | `TextStyle?` | Helper text style |

## Best Practices

1. **Clear Labels**: Use descriptive labels that clearly indicate the field purpose
2. **Validation**: Provide immediate feedback for validation errors
3. **Helper Text**: Use helper text to guide users on input requirements
4. **Accessibility**: Ensure proper labels and descriptions for screen readers
5. **Performance**: Use controllers efficiently and dispose them properly
6. **User Experience**: Provide clear visual feedback for different states
7. **Security**: Handle sensitive data appropriately (passwords, etc.)

## Accessibility

- All input fields support proper touch targets
- Screen reader support for labels, hints, and error messages
- Keyboard navigation support
- High contrast mode support
- Proper semantic structure for assistive technologies
