import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Booking Projects Exhibition',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.purple,
        scaffoldBackgroundColor: const Color(0xFFFFF6FC),
      ),
      home: const RegistrationFormScreen(),
    );
  }
}

class RegistrationFormScreen extends StatefulWidget {
  const RegistrationFormScreen({super.key});

  @override
  State<RegistrationFormScreen> createState() => _RegistrationFormScreenState();
}

class _RegistrationFormScreenState extends State<RegistrationFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String? fullName;
  String? email;
  String? projectName;
  String? bookingType;
  String role = 'Developer';
  DateTime? selectedDate;
  bool confirmed = false;

  final List<String> bookingTypes = [
    'Hotel Booking',
    'Clinic Booking',
    'Restaurant Booking',
    'Travel Booking',
    'Event Booking',
  ];

  String formatDate(DateTime? date) {
    if (date == null) {
      return 'No date selected';
    }
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select the exhibition date'),
        ),
      );
      return;
    }

    if (!confirmed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please confirm your information'),
        ),
      );
      return;
    }

    _formKey.currentState!.save();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketScreen(
          fullName: fullName!,
          email: email!,
          projectName: projectName!,
          bookingType: bookingType!,
          role: role,
          date: formatDate(selectedDate),
        ),
      ),
    );
  }

  InputDecoration fieldDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Projects Exhibition'),
        centerTitle: true,
        backgroundColor: Colors.purple.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Icon(
                      Icons.event_available,
                      size: 60,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 12),

                  const Center(
                    child: Text(
                      'Third Year Software Engineering Exhibition',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Center(
                    child: Text(
                      'Booking Projects Registration Form',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  TextFormField(
                    decoration: fieldDecoration('Full Name', Icons.person),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your full name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      fullName = value;
                    },
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    decoration: fieldDecoration('Email', Icons.email),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      email = value;
                    },
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    decoration: fieldDecoration('Project Name', Icons.apps),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your project name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      projectName = value;
                    },
                  ),

                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    decoration: fieldDecoration(
                      'Booking Project Type',
                      Icons.category,
                    ),
                    value: bookingType,
                    items: bookingTypes.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        bookingType = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select booking type';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      bookingType = value;
                    },
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    'Your Role in the Project:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  RadioListTile<String>(
                    title: const Text('Developer'),
                    value: 'Developer',
                    groupValue: role,
                    onChanged: (value) {
                      setState(() {
                        role = value!;
                      });
                    },
                  ),

                  RadioListTile<String>(
                    title: const Text('Designer'),
                    value: 'Designer',
                    groupValue: role,
                    onChanged: (value) {
                      setState(() {
                        role = value!;
                      });
                    },
                  ),

                  RadioListTile<String>(
                    title: const Text('Presenter'),
                    value: 'Presenter',
                    groupValue: role,
                    onChanged: (value) {
                      setState(() {
                        role = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 12),

                  InkWell(
                    onTap: selectDate,
                    borderRadius: BorderRadius.circular(18),
                    child: InputDecorator(
                      decoration: fieldDecoration(
                        'Exhibition Date',
                        Icons.calendar_month,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(formatDate(selectedDate)),
                          const Icon(Icons.touch_app),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('I confirm that my information is correct'),
                    value: confirmed,
                    onChanged: (value) {
                      setState(() {
                        confirmed = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),

                  const SizedBox(height: 22),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: submitForm,
                      icon: const Icon(Icons.confirmation_number),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          'Submit Registration',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TicketScreen extends StatelessWidget {
  final String fullName;
  final String email;
  final String projectName;
  final String bookingType;
  final String role;
  final String date;

  const TicketScreen({
    super.key,
    required this.fullName,
    required this.email,
    required this.projectName,
    required this.bookingType,
    required this.role,
    required this.date,
  });

  Widget ticketRow(String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.purple),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF6FC),
      appBar: AppBar(
        title: const Text('Registration Ticket'),
        backgroundColor: Colors.purple.shade100,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 550),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                const Icon(
                  Icons.confirmation_number,
                  size: 70,
                  color: Colors.purple,
                ),
                const SizedBox(height: 12),

                const Text(
                  'Booking Projects Exhibition Ticket',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Third Year Software Engineering',
                  style: TextStyle(color: Colors.black54),
                ),

                const SizedBox(height: 24),

                ticketRow('Full Name', fullName, Icons.person),
                ticketRow('Email', email, Icons.email),
                ticketRow('Project Name', projectName, Icons.apps),
                ticketRow('Booking Type', bookingType, Icons.category),
                ticketRow('Role', role, Icons.work),
                ticketRow('Exhibition Date', date, Icons.calendar_month),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Back to Form'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}