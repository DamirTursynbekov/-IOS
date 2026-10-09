import 'package:flutter/material.dart';

void main() {
  runApp(const RegistrationApp());
}

class RegistrationApp extends StatelessWidget {
  const RegistrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Registration',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF476A36),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F7F2),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
          errorMaxLines: 3,
        ),
      ),
      home: const RegistrationScreen(),
    );
  }
}

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() =>
      _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _confirmKey = GlobalKey<FormFieldState<String>>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  String _role = 'Student';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _register() {
    FocusScope.of(context).unfocus();

    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    debugPrint('----- REGISTRATION -----');
    debugPrint('Full name: ${_nameController.text.trim()}');
    debugPrint('Email: ${_emailController.text.trim()}');
    debugPrint('Role: $_role');
    debugPrint('Terms accepted: true');
    debugPrint('Password: [hidden]');

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Registration successful, ${_nameController.text.trim()}!',
        ),
        backgroundColor: Colors.green.shade700,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create account'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.person_add_alt_1,
                      size: 56,
                      color: Color(0xFF476A36),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Welcome!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Fill in your details to set up your profile.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 28),

                    // Full name
                    TextFormField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your full name.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),

                    // Email
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'name@narxoz.kz',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        final email = value?.trim() ?? '';

                        if (email.isEmpty) {
                          return 'Please enter your email.';
                        }

                        final pattern = RegExp(
                          r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                        );

                        if (!pattern.hasMatch(email)) {
                          return 'Enter a valid email, e.g. name@narxoz.kz.';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 18),

                    // Password
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        helperText: 'At least 6 characters',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      onChanged: (_) {
                        // Recheck confirmation if the password changes.
                        if (_confirmController.text.isNotEmpty) {
                          _confirmKey.currentState?.validate();
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password.';
                        }

                        if (value.length < 6) {
                          return 'Password must have at least 6 characters.';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 18),

                    // Confirm password
                    TextFormField(
                      key: _confirmKey,
                      controller: _confirmController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(Icons.lock_person_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password.';
                        }

                        if (value != _passwordController.text) {
                          return 'Passwords do not match.';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 18),

                    // User role
                    DropdownButtonFormField<String>(
                      initialValue: _role,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        labelText: 'User role',
                        prefixIcon: Icon(Icons.badge_outlined),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Student',
                          child: Text('Student'),
                        ),
                        DropdownMenuItem(
                          value: 'Teacher',
                          child: Text('Teacher'),
                        ),
                        DropdownMenuItem(
                          value: 'Developer',
                          child: Text('Developer'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _role = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    // Checkbox participates in Form validation.
                    FormField<bool>(
                      initialValue: false,
                      validator: (value) {
                        if (value != true) {
                          return 'You must accept the Terms and Conditions.';
                        }
                        return null;
                      },
                      builder: (field) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              controlAffinity:
                              ListTileControlAffinity.leading,
                              title: const Text(
                                'I accept the Terms and Conditions',
                              ),
                              value: field.value ?? false,
                              onChanged: (value) {
                                field.didChange(value ?? false);
                              },
                            ),
                            if (field.hasError)
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 12,
                                  bottom: 8,
                                ),
                                child: Text(
                                  field.errorText!,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .error,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    FilledButton(onPressed: _register,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                    ),
                    child: const Text("Register",
                    style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}