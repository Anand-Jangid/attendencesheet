import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTextField extends StatefulWidget {
  final TextEditingController dateController;

  const DateTextField({Key? key,
    required this.dateController,
  }) : super(key: key);

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.dateController,
      validator:(val)=> val!.isEmpty?'Please Select the Date':null,
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100));
        if (pickedDate != null) {
          String formatteddate = DateFormat('yyyy-MM-dd').format(pickedDate);
          setState(() {
            widget.dateController.text = formatteddate;
          });
        }
      },
      decoration: InputDecoration(
          hintText: 'Select Date',
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7))),
    );
  }
}
