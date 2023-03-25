import 'package:flutter/material.dart';

import 'dummy_data.dart';

class Categories extends StatefulWidget {
  Categories({
    super.key,
    required this.onCategory,
  });

  void Function(String) onCategory;

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  dynamic categorySelected = "Sem categoria";
  @override
  Widget build(BuildContext context) {
    final List<String> categories = gamesByCategory.keys.toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Container(
        height: 130,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: categories.map((catName) {
              return Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        backgroundColor: categorySelected == catName
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.tertiary,
                        fixedSize: categorySelected == catName
                            ? Size(85, 85)
                            : Size(80, 80),
                      ),
                      onPressed: () {
                        widget.onCategory(catName);
                        setState(() {
                          if (categorySelected != catName) {
                            categorySelected = catName;
                          } else if (categorySelected == catName) {
                            categorySelected = null;
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Image.asset(
                          'assets/images/game_icon.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      catName,
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  ],
                ),
              );
            }).toList()),
      ),
    );
  }
}
