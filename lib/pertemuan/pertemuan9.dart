import 'package:flutter/material.dart';

class Pertemuan9Page extends StatelessWidget {
  const Pertemuan9Page({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date & Time Picker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const DateTimePickerForm(),
    );
  }
}

class DateTimePickerForm extends StatefulWidget {
  const DateTimePickerForm({super.key});

  @override
  State<DateTimePickerForm> createState() => _DateTimePickerFormState();
}

class _DateTimePickerFormState extends State<DateTimePickerForm> {
  final _formKey = GlobalKey<FormState>();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  DateTime? _selectedDateTime;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _dateTimeController.dispose();
    super.dispose();
  }

  // Format helpers (tanpa package intl / locale)
  static const _namaBulan = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  String _fmtDate(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')} ${_namaBulan[d.month - 1]} ${d.year}';

  String _fmtDateShort(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')} ${_namaBulan[d.month - 1].substring(0, 3)} ${d.year}';

  String _fmtTime(TimeOfDay t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  // Picker: Date
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = _fmtDate(picked);
      });
    }
  }

  // Picker: Time
  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = _fmtTime(picked);
      });
    }
  }

  // Picker: Date Range
  Future<void> _pickDateRange() async {
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: (_selectedStartDate != null && _selectedEndDate != null)
          ? DateTimeRange(start: _selectedStartDate!, end: _selectedEndDate!)
          : null,
    );
    if (range != null) {
      setState(() {
        _selectedStartDate = range.start;
        _selectedEndDate = range.end;
        _startDateController.text = _fmtDateShort(range.start);
        _endDateController.text = _fmtDateShort(range.end);
      });
    }
  }

  // Picker: Date + Time
  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: _selectedDateTime != null
          ? TimeOfDay.fromDateTime(_selectedDateTime!)
          : TimeOfDay.now(),
    );
    if (time == null) return;

    setState(() {
      _selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      _dateTimeController.text = '${_fmtDate(date)} ${_fmtTime(time)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Date & Time Picker')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Tambahkan TextFormField dan picker field sesuai kebutuhan
            ],
          ),
        ),
      ),
    );
  }
}
