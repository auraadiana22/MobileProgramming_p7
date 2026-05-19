import 'package:flutter/material.dart';

class Pertemuan9Page extends StatefulWidget {
  const Pertemuan9Page({super.key});

  @override
  State<Pertemuan9Page> createState() => _Pertemuan9PageState();
}

class _Pertemuan9PageState extends State<Pertemuan9Page> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();

  // Selected values
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  DateTime? _selectedDateTime;

  bool get _hasAnyValue =>
      _titleController.text.isNotEmpty ||
      _dateController.text.isNotEmpty ||
      _timeController.text.isNotEmpty ||
      _startDateController.text.isNotEmpty ||
      _endDateController.text.isNotEmpty ||
      _dateTimeController.text.isNotEmpty;

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

  // Format helpers
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

  // Pickers
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

  void _reset() {
    _formKey.currentState?.reset();
    setState(() {
      _titleController.clear();
      _dateController.clear();
      _timeController.clear();
      _startDateController.clear();
      _endDateController.clear();
      _dateTimeController.clear();
      _selectedDate = null;
      _selectedTime = null;
      _selectedStartDate = null;
      _selectedEndDate = null;
      _selectedDateTime = null;
    });
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text('Form berhasil disimpan!'),
            ],
          ),
          backgroundColor: Colors.deepPurple,
        ),
      );
    }
  }

  Widget _buildPickerField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required VoidCallback onTap,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: const Icon(Icons.calendar_today),
      ),
    );
  }

  Widget _previewRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.deepPurple),
        const SizedBox(width: 6),
        Text('$title: $value', style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date & Time Picker'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Judul Acara',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildPickerField(
                controller: _dateController,
                label: 'Tanggal',
                hint: 'Pilih tanggal',
                onTap: _pickDate,
              ),
              const SizedBox(height: 16),
              _buildPickerField(
                controller: _timeController,
                label: 'Waktu',
                hint: 'Pilih waktu',
                onTap: _pickTime,
              ),
              const SizedBox(height: 16),
              _buildPickerField(
                controller: _startDateController,
                label: 'Tanggal Mulai',
                hint: 'Pilih tanggal mulai',
                onTap: _pickDateRange,
              ),
              const SizedBox(height: 16),
              _buildPickerField(
                controller: _endDateController,
                label: 'Tanggal Selesai',
                hint: 'Pilih tanggal selesai',
                onTap: _pickDateRange,
              ),
              const SizedBox(height: 16),
              _buildPickerField(
                controller: _dateTimeController,
                label: 'Tanggal & Waktu Sekaligus',
                hint: 'Pilih tanggal & waktu',
                onTap: _pickDateTime,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: _reset,
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  side: const BorderSide(color: Colors.deepPurple),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Reset Form', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 24),
              if (_hasAnyValue)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Preview Data:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      if (_titleController.text.isNotEmpty)
                        _previewRow(
                          Icons.title,
                          'Judul',
                          _titleController.text,
                        ),
                      if (_dateController.text.isNotEmpty)
                        _previewRow(
                          Icons.calendar_today,
                          'Tanggal',
                          _dateController.text,
                        ),
                      if (_timeController.text.isNotEmpty)
                        _previewRow(
                          Icons.access_time,
                          'Waktu',
                          _timeController.text,
                        ),
                      if (_startDateController.text.isNotEmpty &&
                          _endDateController.text.isNotEmpty)
                        _previewRow(
                          Icons.date_range,
                          'Rentang',
                          '${_startDateController.text} - ${_endDateController.text}',
                        ),
                      if (_dateTimeController.text.isNotEmpty)
                        _previewRow(
                          Icons.schedule,
                          'Tanggal & Waktu',
                          _dateTimeController.text,
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
