import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  List<String> availableTimeSlots = [];

  @override
  void initState() {
    super.initState();
    fetchAvailableTimeSlots();
  }

  void fetchAvailableTimeSlots() {
    final DateTime now = DateTime.now();
    final DateTime startDate = DateTime(
        now.year, now.month, now.day, 0, 0); // Set the start time as 00:00

    final List<String> slots = [];
    for (int i = 0; i < 24; i++) {
      final DateTime time = startDate.add(Duration(hours: i));
      final String formattedTime =
          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
      slots.add(formattedTime);
    }

    setState(() {
      availableTimeSlots = slots;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Available Time Slots:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 2000,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: availableTimeSlots.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (int.parse(
                                  '${availableTimeSlots[index].toString()[0]}${availableTimeSlots[index].toString()[1]}') <
                              10 ||
                          int.parse(
                                  '${availableTimeSlots[index].toString()[0]}${availableTimeSlots[index].toString()[1]}') >
                              20) {
                        return Container();
                      } else {
                        var found = timelist
                            .where((element) =>
                                element ==
                                "${availableTimeSlots[index]} ${int.parse('${availableTimeSlots[index].toString()[0]}${availableTimeSlots[index].toString()[1]}') < 12 ? 'AM' : 'PM'}")
                            .toList();
                        if (found.isEmpty) {
                          return MaterialButton(
                            onPressed: () {
                              timelist.add(
                                  "${availableTimeSlots[index]} ${int.parse('${availableTimeSlots[index].toString()[0]}${availableTimeSlots[index].toString()[1]}') < 12 ? 'AM' : 'PM'}");
                              setState(() {});
                            },
                            child: Container(
                              color: Colors.blue,
                              child: Center(
                                child: Text(
                                    "${availableTimeSlots[index]} ${int.parse('${availableTimeSlots[index].toString()[0]}${availableTimeSlots[index].toString()[1]}') < 12 ? 'AM' : 'PM'}"),
                              ),
                            ),
                          );
                        } else {
                          return MaterialButton(
                            onPressed: () {},
                            child: Container(
                              color: Colors.red,
                              child: Center(
                                child: Text(
                                    "${availableTimeSlots[index]} ${int.parse('${availableTimeSlots[index].toString()[0]}${availableTimeSlots[index].toString()[1]}') < 12 ? 'AM' : 'PM'}"),
                              ),
                            ),
                          );
                        }
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<String> timelist = [];
}
