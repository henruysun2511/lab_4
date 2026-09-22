import 'package:flutter/material.dart';

/// Entry point cho phép chạy riêng file input_controls_demo.dart độc lập
void main() {
  runApp(const InputControlsApp());
}

/// Ứng dụng bọc cho màn hình Exercise 2
class InputControlsApp extends StatelessWidget {
  const InputControlsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 - Exercise 2: Input Controls',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
      ),
      home: const InputControlsDemo(),
    );
  }
}

/// Màn hình chính Exercise 2 – StatefulWidget InputControlsDemo
/// Thực hành với:
/// 1. Slider: Chọn giá trị trong khoảng
/// 2. Switch: Bật/Tắt trạng thái boolean
/// 3. RadioListTile: Chọn 1 trong nhiều phương án
/// 4. DatePicker: Hộp thoại chọn ngày lịch
/// 5. Live State Dashboard: Hiển thị giá trị cập nhật trực tiếp trên màn hình
class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  // Trạng thái (State) của các điều khiển nhập liệu
  double _sliderValue = 45.0;
  bool _isNotificationEnabled = true;
  String _selectedLevel = 'Trung Bình'; // Options: Cơ bản, Trung Bình, Nâng Cao
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    // Mặc định ngày hôm nay
    _selectedDate = DateTime.now();
  }

  /// Hàm mở DatePicker từ Flutter Material framework
  Future<void> _pickDate() async {
    final DateTime initialDate = _selectedDate ?? DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      helpText: 'CHỌN NGÀY THỰC HIỆN LAB',
      cancelText: 'HỦY',
      confirmText: 'CHỌN',
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  /// Định dạng chuỗi ngày tháng dd/MM/yyyy
  String _formatDate(DateTime? date) {
    if (date == null) return 'Chưa chọn ngày';
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 2: Input Widgets'),
        centerTitle: true,
        backgroundColor: theme.colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ================================================================
            // BẢNG TỔNG HỢP GIÁ TRỊ LIVE (Requirement: Display updated values)
            // ================================================================
            Card(
              elevation: 4.0,
              color: theme.colorScheme.primaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.dashboard_customize_rounded,
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                        const SizedBox(width: 8.0),
                        Text(
                          'Giá Trị Đang Chọn (Live Preview)',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    _buildStatusRow(
                      icon: Icons.tune,
                      label: 'Âm lượng / Giá trị Slider:',
                      value: '${_sliderValue.round()} %',
                      theme: theme,
                    ),
                    const SizedBox(height: 8.0),
                    _buildStatusRow(
                      icon: Icons.notifications_active,
                      label: 'Nhận thông báo (Switch):',
                      value: _isNotificationEnabled ? 'BẬT (Enabled)' : 'TẮT (Disabled)',
                      theme: theme,
                      valueColor: _isNotificationEnabled ? Colors.green.shade800 : Colors.red.shade800,
                    ),
                    const SizedBox(height: 8.0),
                    _buildStatusRow(
                      icon: Icons.speed,
                      label: 'Cấp độ (Radio):',
                      value: _selectedLevel,
                      theme: theme,
                    ),
                    const SizedBox(height: 8.0),
                    _buildStatusRow(
                      icon: Icons.calendar_today,
                      label: 'Ngày đã chọn (DatePicker):',
                      value: _formatDate(_selectedDate),
                      theme: theme,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24.0),

            // ================================================================
            // 1. SLIDER WIDGET
            // ================================================================
            Text(
              '1. Slider (Thanh trượt giá trị 0 - 100):',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Card(
              elevation: 1.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Kéo điều chỉnh:'),
                        Text(
                          '${_sliderValue.toStringAsFixed(1)} / 100',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Slider(
                      value: _sliderValue,
                      min: 0.0,
                      max: 100.0,
                      divisions: 100,
                      label: _sliderValue.round().toString(),
                      onChanged: (double newValue) {
                        setState(() {
                          _sliderValue = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16.0),

            // ================================================================
            // 2. SWITCH WIDGET
            // ================================================================
            Text(
              '2. Switch (Công tắc bật/tắt):',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Card(
              elevation: 1.0,
              child: SwitchListTile(
                secondary: Icon(
                  _isNotificationEnabled ? Icons.notifications_active : Icons.notifications_off,
                  color: _isNotificationEnabled ? theme.colorScheme.primary : Colors.grey,
                ),
                title: const Text('Bật thông báo hệ thống'),
                subtitle: Text(
                  _isNotificationEnabled
                      ? 'Ứng dụng sẽ gửi thông báo tin tức'
                      : 'Đang tắt mọi thông báo đẩy',
                ),
                value: _isNotificationEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _isNotificationEnabled = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 16.0),

            // ================================================================
            // 3. RADIOLISTTILE GROUP WIDGET
            // ================================================================
            Text(
              '3. RadioListTile (Nhóm chọn 1 phương án duy nhất):',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Card(
              elevation: 1.0,
              child: Column(
                children: [
                  // ignore: deprecated_member_use
                  RadioListTile<String>(
                    title: const Text('Cơ Bản (Beginner)'),
                    subtitle: const Text('Dành cho người mới bắt đầu học Flutter'),
                    value: 'Cơ Bản',
                    // ignore: deprecated_member_use
                    groupValue: _selectedLevel,
                    // ignore: deprecated_member_use
                    onChanged: (value) {
                      setState(() {
                        _selectedLevel = value!;
                      });
                    },
                  ),
                  const Divider(height: 1),
                  // ignore: deprecated_member_use
                  RadioListTile<String>(
                    title: const Text('Trung Bình (Intermediate)'),
                    subtitle: const Text('Đã nắm vững widgets và State cơ bản'),
                    value: 'Trung Bình',
                    // ignore: deprecated_member_use
                    groupValue: _selectedLevel,
                    // ignore: deprecated_member_use
                    onChanged: (value) {
                      setState(() {
                        _selectedLevel = value!;
                      });
                    },
                  ),
                  const Divider(height: 1),
                  // ignore: deprecated_member_use
                  RadioListTile<String>(
                    title: const Text('Nâng Cao (Advanced)'),
                    subtitle: const Text('Custom painter, kiến trúc Clean Architecture & testing'),
                    value: 'Nâng Cao',
                    // ignore: deprecated_member_use
                    groupValue: _selectedLevel,
                    // ignore: deprecated_member_use
                    onChanged: (value) {
                      setState(() {
                        _selectedLevel = value!;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16.0),

            // ================================================================
            // 4. DATE PICKER BUTTON
            // ================================================================
            Text(
              '4. DatePicker (Hộp thoại chọn ngày):',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Card(
              elevation: 1.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ngày hoàn thành Lab:',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatDate(_selectedDate),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_month),
                      label: const Text('Chọn Ngày'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow({
    required IconData icon,
    required String label,
    required String value,
    required ThemeData theme,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.8)),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.9),
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: valueColor ?? theme.colorScheme.onPrimaryContainer,
          ),
        ),
      ],
    );
  }
}
