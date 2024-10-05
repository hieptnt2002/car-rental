import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:car_rental/core/extensions/format_date_time_extension.dart';
import 'package:car_rental/features/presentation/components/button/common_button.dart';
import 'package:car_rental/features/presentation/components/button/common_outline_button.dart';
import 'package:car_rental/features/presentation/resources/app_colors.dart';
import 'package:car_rental/features/presentation/resources/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RentalPeriodPicker extends StatefulWidget {
  final DateTime? fromTime;
  final DateTime? lastTime;
  const RentalPeriodPicker({
    super.key,
    required this.fromTime,
    required this.lastTime,
  });

  @override
  State<RentalPeriodPicker> createState() => _RentalPeriodPickerState();
}

class _RentalPeriodPickerState extends State<RentalPeriodPicker> {
  DateTime? _fromTime;
  DateTime? _lastTime;
  String? _timeSelected;
  final List<String> _availableTimes = const [
    '07:00',
    '08:00',
    '09:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00',
    '18:00',
  ];

  @override
  void initState() {
    super.initState();
    _fromTime = widget.fromTime;
    _lastTime = widget.lastTime;
    _timeSelected = _fromTime?.formatTime();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Chọn ngày khởi hành và kết thúc',
              style: AppTextStyle.w700TextColorHeadingXSmall,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text(
                  'Từ',
                  style: AppTextStyle.textColorLabelSmall,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CommonOutlineButton(
                    title: _fromTime?.formatDate() ?? '__/__/____',
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Đến',
                  style: AppTextStyle.textColorLabelSmall,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CommonOutlineButton(
                    title: _lastTime?.formatDate() ?? '__/__/____',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildCalendar(),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Chọn giờ khởi hành',
              style: AppTextStyle.w700TextColorHeadingXSmall,
            ),
          ),
          const SizedBox(height: 16),
          _buildListTime(),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CommonButton(
              title: 'Xác nhận',
              onPressed: !_isValidDateTime ? null : _confirmDateTimeSelection,
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDateTimeSelection() {
    final hours = int.parse(_timeSelected!.substring(0, 2));
    _fromTime = _fromTime!.copyWith(hour: hours);
    _lastTime = _lastTime!.copyWith(hour: hours);

    Navigator.pop(context, [_fromTime, _lastTime]);
  }

  bool get _isValidDateTime =>
      _fromTime != null && _lastTime != null && _timeSelected != null;
  Widget _buildCalendar() {
    return Container(
      color: AppColors.gray100,
      child: CalendarDatePicker2(
        config: CalendarDatePicker2Config(
          calendarType: CalendarDatePicker2Type.range,
          centerAlignModePicker: true,
          rangeBidirectional: true,
          dynamicCalendarRows: true,
          controlsTextStyle: AppTextStyle.secondaryLabelSmall,
          dayTextStyle: AppTextStyle.textColorLabelSmall,
          disabledDayTextStyle: AppTextStyle.gray500LabelSmall,
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
          weekdayLabels: ['Th2', 'Th3', 'Th4', 'Th5', 'Th6', 'Th7', 'CN'],
          selectedDayHighlightColor: AppColors.secondary,
          selectedDayTextStyle: AppTextStyle.whiteLabelSmall,
          daySplashColor: AppColors.gray200,
          weekdayLabelTextStyle: AppTextStyle.primaryLabelSmall,
          customModePickerIcon: const SizedBox(),
          modePickerTextHandler: ({isMonthPicker, required monthDate}) =>
              DateFormat('MMMM yyyy').format(monthDate),
          disableMonthPicker: true,
          disableModePicker: true,
        ),
        value: [_fromTime, _lastTime],
        onValueChanged: (value) {
          setState(() {
            _fromTime = value[0];
            if (value.length == 2) {
              final int differenceDays = value[1].difference(value[0]).inDays;
              if (differenceDays >= 1) {
                _lastTime = differenceDays <= 10
                    ? value[1]
                    : _fromTime!.add(const Duration(days: 10));
              }
            } else {
              _lastTime = null;
            }
          });
        },
      ),
    );
  }

  Widget _buildListTime() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 32,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _availableTimes.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            setState(() {
              _timeSelected = _availableTimes[index];
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: _timeSelected == _availableTimes[index]
                  ? AppColors.secondary
                  : AppColors.gray400,
            ),
            alignment: Alignment.center,
            child: Text(
              _availableTimes[index],
              style: _timeSelected == _availableTimes[index]
                  ? AppTextStyle.whiteBodySmall
                  : AppTextStyle.textColorBodySmall,
            ),
          ),
        );
      },
    );
  }
}
