import 'package:flutter/material.dart';

import '../../utility/app_colors.dart';

class SizeSelector extends StatefulWidget {
  const SizeSelector({super.key, required this.sizes, required this.onTap});
  final List<String> sizes ;
  final Function(String) onTap;

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  late String isSelectedSize;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSelectedSize=widget.sizes.first;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.sizes.map((s) => InkWell(
        splashColor: Colors.transparent,
        onTap: (){
          widget.onTap(s);
          setState(() {
            isSelectedSize=s;
          });
        },
        child: Container(
          margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.withOpacity(.4)),
              color: isSelectedSize==s?AppColors.primaryColor:Colors.white,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(s, style: TextStyle(
                    color: isSelectedSize==s?Colors.white:Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                ),),
              ),
            )
        ),
      )).toList(),

    );
  }
}