import 'package:flutter/material.dart';
import '../../data/models/home_model.dart';

class EarnBonus extends StatelessWidget {
  final List<Bonus> bonus;
  const EarnBonus({super.key, required this.bonus});

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Earn More With Bonus",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800)),
        ListView.builder(
          itemCount: bonus.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Card(
              elevation: 1,
              child: ListTile(
                isThreeLine: true,
                leading: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          color: Colors.grey,
                          spreadRadius: 3)
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                      bonus[index].image?.path ?? "",
                    ),
                  ),
                ),
                title: Text(bonus[index].name ?? "",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                        fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(bonus[index].description ?? "",
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold)),
                    bonus[index].expirationDate != null ?
                    Container(
                      width: 200,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.timer_outlined,
                              color: Colors.white70),
                          Expanded(
                            // flex: 2,
                            child: Text(
                              bonus[index].expirationDate ?? "",
                              style: const TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ): Container()
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              minimumSize: const Size.fromHeight(60),
              side: const BorderSide(
                  color: Color.fromARGB(255, 16, 98, 92),
                  width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {},
            child: const Text(
              "See All Bonuses",
              style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 16, 98, 92)),
            )),
      ],
    );
  }
}
