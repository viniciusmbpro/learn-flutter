import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class StarBar extends StatelessWidget {
  StarBar({super.key, required this.numStars});

  int numStars;

  @override
  Widget build(BuildContext context) {
    int aux = numStars;

    return Row(
      children: [
        for (; numStars > (aux - 10); numStars -= 2)
          Stack(
            children: [
              Container(
                height: 20,
                width: 20,
                child: Image.asset(
                  "assets/images/icon_star_full_rating.png",
                  fit: BoxFit.cover,
                  color: Color.fromARGB(255, 95, 95, 95),
                ),
              ),
              if (numStars >= 2)
                Container(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    "assets/images/icon_star_full_rating.png",
                    fit: BoxFit.cover,
                    color: Color.fromARGB(255, 250, 204, 0),
                  ),
                ),
              if (numStars == 1)
                Container(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    "assets/images/icon_star_midle_rating.png",
                    fit: BoxFit.cover,
                    color: Color.fromARGB(255, 250, 204, 0),
                  ),
                ),
              if (numStars <= 0)
                Container(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    "assets/images/icon_star_no_rating.png",
                    fit: BoxFit.cover,
                    color: Color.fromARGB(255, 250, 204, 0),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
