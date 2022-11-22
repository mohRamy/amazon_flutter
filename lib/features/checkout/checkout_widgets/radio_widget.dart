import 'package:flutter/material.dart';

import '../../../core/utils/dimensions.dart';

class RadioWidget extends StatefulWidget {
  final String image;
  final String title;
  final Radio radio;
  const RadioWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.radio,
  }) : super(key: key);

  @override
  State<RadioWidget> createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                offset: const Offset(0, 2),
                color: Colors.grey.withOpacity(0.2),
              ),
            ],
          ),
          child: ListTile(
            leading: SizedBox(
              width: 40,
              child: Image.asset(
                widget.image,
                height: Dimensions.height10 * 3,
              ),
            ),
            title: Text(
              widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: widget.radio,
          ),
        ),
        SizedBox(height: Dimensions.height10),
      ],
    );
  }
}
