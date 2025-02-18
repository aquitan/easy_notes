import 'package:flutter/material.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 147.0,
      height: 180.0,
      child: ListView.separated(
        separatorBuilder: (_, index) => const SizedBox(width: 10.0,),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.tertiaryFixedDim,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Stack(
              children: [
                Text('Category Name'),
                Text('Image')
              ],
            ),
          );
        },
      ),
    );
  }
}