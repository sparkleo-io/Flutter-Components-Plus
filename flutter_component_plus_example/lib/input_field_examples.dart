import 'package:flutter/material.dart';
import 'package:flutter_components_plus/flutter_components_plus.dart';

/// Comprehensive examples of FCPInputFields usage
class FCPInputFieldExamples extends StatefulWidget {
  const FCPInputFieldExamples({super.key});

  @override
  State<FCPInputFieldExamples> createState() => _FCPInputFieldExamplesState();
}

class _FCPInputFieldExamplesState extends State<FCPInputFieldExamples> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _urlController = TextEditingController();
  final _searchController = TextEditingController();
  final _numberController = TextEditingController();
  final _decimalController = TextEditingController();
  final _dateController = TextEditingController();
  final _multilineController = TextEditingController();

  // Country picker state
  String? _selectedCountry;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _urlController.dispose();
    _searchController.dispose();
    _numberController.dispose();
    _decimalController.dispose();
    _dateController.dispose();
    _multilineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FCPInputField Examples')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection('Basic Input Fields', [
                FCPInputFields.text(
                  label: 'Full Name',
                  hint: 'Enter your full name',
                  controller: _nameController,
                  prefixIcon: const Icon(Icons.person_outline),
                ),
                const SizedBox(height: 16),
                FCPInputFields.email(controller: _emailController),
                const SizedBox(height: 16),
                FCPInputFields.password(controller: _passwordController),
              ]),

              const SizedBox(height: 24),
              _buildSection('Numeric Input Fields', [
                FCPInputFields.integer(
                  label: 'Age',
                  hint: 'Enter your age',
                  controller: _numberController,
                ),
                const SizedBox(height: 16),
                FCPInputFields.floatField(
                  label: 'Price',
                  hint: 'Enter price (e.g., 99.99)',
                  controller: _decimalController,
                ),
              ]),

              const SizedBox(height: 24),
              _buildSection('Contact Information', [
                FCPInputFields.phone(controller: _phoneController),
                const SizedBox(height: 16),
                FCPInputFields.url(
                  label: 'Website',
                  hint: 'Enter your website URL',
                  controller: _urlController,
                ),
              ]),

              const SizedBox(height: 24),
              _buildSection('Search and Selection', [
                FCPInputFields.search(
                  label: 'Search Products',
                  hint: 'Search for products...',
                  controller: _searchController,
                  onSearchPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Searching for: ${_searchController.text}',
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                FCPInputFields.datePicker(
                  label: 'Birth Date',
                  hint: 'Select your birth date',
                  controller: _dateController,
                  context: context,
                ),
              ]),

              const SizedBox(height: 24),
              _buildSection('Country Picker Example', [
                FCPInputFields.countryPicker(
                  label: 'Select Your Country',
                  hint: 'Choose from the list of countries',
                  initialValue: _selectedCountry,
                  onChanged: (country) {
                    setState(() {
                      _selectedCountry = country;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Selected country: $country'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
                if (_selectedCountry != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Selected Country: $_selectedCountry',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                FCPButton.medium.secondary(
                  text: 'Clear Country Selection',
                  onPressed: _selectedCountry != null
                      ? () {
                          setState(() {
                            _selectedCountry = null;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Country selection cleared'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      : null,
                  icon: Icons.clear,
                  iconPosition: IconPosition.start,
                ),
              ]),

              const SizedBox(height: 24),
              _buildSection('Multiline and Special Inputs', [
                FCPInputFields.text(
                  label: 'Bio',
                  hint: 'Tell us about yourself...',
                  controller: _multilineController,
                  maxLines: 4,
                  maxLength: 200,
                  prefixIcon: const Icon(Icons.description_outlined),
                ),
                const SizedBox(height: 16),
                FCPInputField(
                  label: 'Custom Input Field',
                  hint: 'This is a custom input field',
                  prefixIcon: const Icon(Icons.edit_outlined),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      // Clear functionality
                    },
                  ),
                ),
              ]),

              const SizedBox(height: 24),
              _buildSection('Input Field States', [
                FCPInputField(
                  label: 'Disabled Input',
                  hint: 'This field is disabled',
                  enabled: false,
                  prefixIcon: const Icon(Icons.lock),
                ),
                const SizedBox(height: 16),
                FCPInputField(
                  label: 'Read Only Input',
                  hint: 'This field is read only',
                  readOnly: true,
                  initialValue: 'Read only value',
                  prefixIcon: const Icon(Icons.visibility),
                ),
                const SizedBox(height: 16),
                FCPInputField(
                  label: 'Input with Error',
                  hint: 'This field has an error',
                  errorText: 'This field is required',
                  prefixIcon: const Icon(Icons.error_outline),
                ),
              ]),

              const SizedBox(height: 24),
              _buildSection('Input Field with Validation', [
                FCPInputField(
                  label: 'Username',
                  hint: 'Enter username (min 3 characters)',
                  validator: FCPValidators.minLength(3),
                  prefixIcon: const Icon(Icons.account_circle_outlined),
                ),
                const SizedBox(height: 16),
                FCPInputField(
                  label: 'Phone Number',
                  hint: 'Enter phone number',
                  validator: FCPValidators.phoneNumber,
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone_outlined),
                ),
              ]),

              const SizedBox(height: 24),
              _buildSection('Form Actions', [
                Row(
                  children: [
                    Expanded(
                      child: FCPButton.medium.primary(
                        text: 'Submit Form',
                        onPressed: _submitForm,
                        icon: Icons.send,
                        iconPosition: IconPosition.start,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: FCPButton.medium.secondary(
                        text: 'Reset Form',
                        onPressed: _resetForm,
                        icon: Icons.refresh,
                        iconPosition: IconPosition.start,
                      ),
                    ),
                  ],
                ),
              ]),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Form submitted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fix the errors in the form'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _emailController.clear();
    _passwordController.clear();
    _nameController.clear();
    _phoneController.clear();
    _urlController.clear();
    _searchController.clear();
    _numberController.clear();
    _decimalController.clear();
    _dateController.clear();
    _selectedCountry = null;
    _multilineController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Form reset successfully!'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

/// Usage examples in code comments
class FCPInputFieldUsageExamples {
  // Basic usage examples:

  // Email input field
  // FCPInputFields.email(
  //   controller: emailController,
  //   onChanged: (value) => print('Email: $value'),
  // )

  // Password input field
  // FCPInputFields.password(
  //   controller: passwordController,
  //   validator: FCPValidators.password,
  // )

  // Text input field with custom styling
  // FCPInputFields.text(
  //   label: 'Custom Label',
  //   hint: 'Custom hint text',
  //   prefixIcon: Icon(Icons.person),
  //   maxLines: 3,
  //   maxLength: 100,
  // )

  // Phone number input field
  // FCPInputFields.phone(
  //   controller: phoneController,
  //   validator: FCPValidators.phoneNumber,
  // )

  // Search field with callback
  // FCPInputFields.search(
  //   controller: searchController,
  //   onSearchPressed: () => performSearch(),
  // )

  // Country picker
  // FCPInputFields.countryPicker(
  //   onChanged: (country) => print('Selected: $country'),
  // )

  // Date picker
  // FCPInputFields.datePicker(
  //   context: context,
  //   controller: dateController,
  //   firstDate: DateTime(1900),
  //   lastDate: DateTime.now(),
  // )

  // Custom input field
  // FCPInputField(
  //   label: 'Custom Field',
  //   hint: 'Enter custom data',
  //   validator: FCPValidators.required,
  //   prefixIcon: Icon(Icons.star),
  //   suffixIcon: IconButton(
  //     icon: Icon(Icons.clear),
  //     onPressed: () => controller.clear(),
  //   ),
  // )
}
