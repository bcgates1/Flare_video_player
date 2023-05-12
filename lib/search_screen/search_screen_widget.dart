import 'package:flutter/material.dart';

class SearchFilterSelect extends StatefulWidget {
  bool filter1;
  bool filter2;
  SearchFilterSelect({super.key, required this.filter1, required this.filter2});

  @override
  State<SearchFilterSelect> createState() => _SearchFilterSelectState();
}

class _SearchFilterSelectState extends State<SearchFilterSelect> {
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: widget.filter1,
      onChanged: (bool? value) {
        setState(() {
          widget.filter1 = value!;
          widget.filter2 = !widget.filter1;
        });
      },
    );
  }
}
