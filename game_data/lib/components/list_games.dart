import 'dart:math';

import 'package:flutter/material.dart';
import 'package:game_data/components/star_bar.dart';

class ListGames extends StatelessWidget {
  const ListGames({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const List<String> games = [
      'The Legend of Zelda: Breath of the Wild',
      'Red Dead Redemption 2',
      'Overwatch',
      'Minecraft',
      'Grand Theft Auto V',
      'Super Mario Odyssey',
      'Apex Legends',
      'League of Legends',
      'Destiny 2',
      'Fortnite',
      'FIFA 22',
      'Assassin\'s Creed Valhalla',
      'Resident Evil Village',
      'Rainbow Six Siege',
      'Valorant',
      'Call of Duty: Warzone',
      'Battlefield 2042',
      'Cyberpunk 2077',
      'Deathloop',
      'Forza Horizon 5',
      'The Elder Scrolls V: Skyrim',
      'Dark Souls III',
      'Sekiro: Shadows Die Twice',
      'God of War',
      'The Last of Us Part II',
      'Horizon Zero Dawn',
      'Animal Crossing: New Horizons',
      'Mario Kart 8 Deluxe',
      'Splatoon 2',
      'Ring Fit Adventure',
    ];
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...[
            Text(
              "All Games",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )
          ],
          ...games.map((game) {
            return Container(
              height: 130,
              width: double.infinity,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color.fromARGB(95, 204, 204, 204),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Image.asset(
                        'assets/images/games/the-witcher.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  LayoutBuilder(builder: (ctx, constraints) {
                    return Container(
                      width: 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: constraints.maxHeight * 0.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  game,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: constraints.maxHeight * 0.6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Ação",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    StarBar(numStars: Random().nextInt(10)),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Ver mais",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Theme.of(context).colorScheme.tertiary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            );
          }).toList()
        ],
      ),
    );
  }
}
