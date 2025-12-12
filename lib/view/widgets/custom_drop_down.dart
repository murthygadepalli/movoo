import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../theme/app_decoration.dart';
import '../../utils/constants/colors.dart';

class CustomDropdown extends StatefulWidget {
  final String hintText;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final double? dropdownWidth;
  final double? buttonWidth;
  final String? selectedValue;

  const CustomDropdown({
    super.key,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.dropdownWidth,
    this.buttonWidth,
    this.selectedValue,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedOption;
  bool isDropdownOpened = false;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: widget.buttonWidth ?? MediaQuery.of(context).size.width, // Button width
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDropdownOpened ? AppColors.primary : Colors.grey.shade300,
          width: 1,
        ),
        boxShadow: AppDecoration.shadow1_2
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          items: widget.items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  if(widget.items.last != item )
                    Container(
                      height: 1,
                      color: Colors.grey,
                    )
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedOption = value; // Update the selected option
            });
            widget.onChanged(selectedOption);
          },
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              selectedOption ?? widget.hintText,
              style: TextStyle(fontSize: 16, color:  selectedOption != null ? AppColors.black: AppColors.darkGrey),
            ),
          ),
          iconStyleData: IconStyleData(
            icon: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(
                isDropdownOpened
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
            ),
          ),
          onMenuStateChange: (isOpen) {
            setState(() {
              isDropdownOpened = isOpen; // Update the dropdown open state
            });
          },
          dropdownStyleData: DropdownStyleData(
             //width: widget.dropdownWidth ?? MediaQuery.of(context).size.width - 32,
            width: widget.dropdownWidth ?? widget.buttonWidth,
            maxHeight: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}