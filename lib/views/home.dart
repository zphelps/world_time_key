import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map? data = {};

  @override
  Widget build(BuildContext context) {

    data = data!.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map?;

    // set background image
    String bgImage = data!['isDaytime'] ? 'day.jpg' : 'night.jpg';
    Color bgColor = data!['isDaytime'] ? Colors.blue : Colors.indigo.shade700;

    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            )
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          data!['location'],
                          style: const TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 2.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0),
                    Text(
                        data!['time'],
                        style: const TextStyle(
                            fontSize: 66.0,
                            color: Colors.white,
                          fontWeight: FontWeight.w700,
                        )
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          dynamic result = await Navigator.pushNamed(context, '/location');
          if(result != null){
            setState(() {
              data = {
                'time': result['time'],
                'location': result['location'],
                'isDaytime': result['isDaytime'],
                'flag': result['flag']
              };
            });
          }
        },
        child: const Icon(
          Icons.edit_location_outlined,
        ),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }
}