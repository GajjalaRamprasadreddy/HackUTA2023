import 'package:flutter/material.dart';

class DatePickerWidget extends StatefulWidget {
  final String label;
  final String? currentDate;
  final Function onDateSelected;

  const DatePickerWidget(
      {Key? key,
      required this.label,
      this.currentDate,
      required this.onDateSelected})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DatePickerWidgetState();
  }
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Date of birth",
          style: Theme.of(context).textTheme.labelMedium,
        ),
        SizedBox(
          height: 5,
        ),

        InkWell(
          onTap: () {
            _selectDate(context);
          },
          child: Material(
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.only(
                  left: 12.0, right: 15.0, top: 20.0, bottom: 20.0),
              width: double.infinity,
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.grey[200]!),),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.currentDate != null ? widget.currentDate! : widget.label,
                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 15,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Call this in the select year button.
  void _selectDate(BuildContext context) {
    widget.onDateSelected();
  }
}
