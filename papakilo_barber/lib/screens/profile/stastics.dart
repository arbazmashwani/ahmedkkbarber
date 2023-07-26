import 'package:flutter/material.dart';
import 'package:papakilo_barber/constants/colors.dart';
import 'package:fl_chart/fl_chart.dart';

class StasticsPage extends StatelessWidget {
  const StasticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themecolorDarkBlue,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.cancel_outlined,
                      color: Colors.grey,
                      size: 25,
                    ))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Sales",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(12)),
                    height: 50,
                    width: 200,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              height: 50,
                              width: 170 / 3,
                              decoration: BoxDecoration(
                                  color: index == 0 ? Colors.blue : null,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                child: Text(
                                  index == 0
                                      ? "Today"
                                      : index == 1
                                          ? "Week"
                                          : "More",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: index == 0
                                          ? Colors.black
                                          : Colors.grey),
                                ),
                              ),
                            ),
                          );
                        })),
              )
            ],
          ),
          const Divider(
            color: Colors.white12,
          ),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "OverView",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    "Earned so far today estimated",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                    child: Container(
                  child: const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "\$720",
                            style: TextStyle(
                                fontSize: 50,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    "Project Income",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                    child: Container(
                  child: const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "\$1290",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.start,
                maxY: 15, // Set the maximum value for the Y-axis
                barTouchData: BarTouchData(enabled: false),
                titlesData: const FlTitlesData(show: false), // Hide all titles
                borderData: FlBorderData(show: false), // Hide borders
                gridData: const FlGridData(show: true),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [BarChartRodData(color: Colors.blue, toY: 10)],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [BarChartRodData(color: Colors.blue, toY: 10)],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [BarChartRodData(color: Colors.blue, toY: 5)],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [BarChartRodData(color: Colors.blue, toY: 10)],
                  ),
                  BarChartGroupData(
                    x: 4,
                    barRods: [BarChartRodData(color: Colors.blue, toY: 10)],
                  ),
                  BarChartGroupData(
                    x: 5,
                    barRods: [BarChartRodData(color: Colors.blue, toY: 10)],
                  ),
                  BarChartGroupData(
                    x: 0,
                    barRods: [BarChartRodData(color: Colors.blue, toY: 10)],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [BarChartRodData(color: Colors.blue, toY: 10)],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [BarChartRodData(color: Colors.blue, toY: 5)],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [BarChartRodData(color: Colors.blue, toY: 10)],
                  ),
                  BarChartGroupData(
                    x: 4,
                    barRods: [BarChartRodData(color: Colors.blue, toY: 10)],
                  ),
                  BarChartGroupData(
                    x: 5,
                    barRods: [BarChartRodData(color: Colors.blue, toY: 10)],
                  ),
                  BarChartGroupData(
                    x: 0,
                    barRods: [BarChartRodData(color: Colors.blue, toY: 10)],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [BarChartRodData(color: Colors.blue, toY: 10)],
                  ),
                  BarChartGroupData(
                    x: 2,
                    barRods: [BarChartRodData(color: Colors.blue, toY: 5)],
                  ),
                  BarChartGroupData(
                    x: 3,
                    barRods: [BarChartRodData(color: Colors.blue, toY: 10)],
                  ),
                  BarChartGroupData(
                    x: 15,
                    barRods: [BarChartRodData(color: Colors.blue, toY: 10)],
                  ),
                  BarChartGroupData(
                    x: 5,
                    barRods: [BarChartRodData(color: Colors.blue, toY: 10)],
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.white12,
          ),
          ListView.builder(
              itemCount: 4,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const ListTile(
                  trailing: Text(
                    "\$71",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  subtitle: Text(
                    "Avg 30%",
                    style: TextStyle(color: Colors.white24),
                  ),
                  title: Text(
                    "Commissions",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              })
        ],
      ),
    );
  }
}
