import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    String bgImage = data['isDayTime'] == true ? 'day.png' : 'night.png';
    print(data);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/$bgImage'), fit: BoxFit.cover)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');

                    if (result != null) {
                      setState(() {
                        data = {
                          'location': result['location'],
                          'flag': result['flag'],
                          'time': result['time'],
                          'isDayTime': result['isDayTime']
                        };
                      });
                    }
                  },
                  label: const Text(
                    'edit location',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(
                    Icons.edit_location,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  data['location']!,
                  style: const TextStyle(
                      fontSize: 28.0, letterSpacing: 2, color: Colors.white),
                ),
                Text(
                  data['time']!,
                  style: const TextStyle(
                      fontSize: 60.0, letterSpacing: 2, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
