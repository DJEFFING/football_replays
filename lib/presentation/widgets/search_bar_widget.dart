import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget{
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final String hintext;
  final TextEditingController? controller;

  const SearchBarWidget({
    super.key,
    this.onChanged,
    this.onClear,
    this.hintext = "Search....",
    this.controller
  });

  @override
  Widget build(BuildContext context){
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintext,
        prefixIcon: const Icon(Icons.search),
        suffixIcon: controller != null && controller!.text.isNotEmpty 
        ? IconButton(
          icon: const Icon(Icons.clear),
          onPressed: (){
            controller!.clear();
            if (onClear !=null) onClear!();
            if(onChanged!=null) onChanged!("");
          },
        ) : null,
        filled:  true,
        fillColor: Colors.grey.shade200,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none
        )
      ),
    );
  }

}