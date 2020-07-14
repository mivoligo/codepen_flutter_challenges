import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class Location {
  final String name;
  final String imageUrl;

  Location({this.name, this.imageUrl});
}

List featuredLocations = [
  Location(
      name: 'Tatra Mountains',
      imageUrl:
          'https://raw.githubusercontent.com/mivoligo/resources/master/tatry.jpg'),
  Location(
      name: 'Paris',
      imageUrl:
          'https://raw.githubusercontent.com/mivoligo/resources/master/france.jpg'),
  Location(
      name: 'Honsiu',
      imageUrl:
          'https://raw.githubusercontent.com/mivoligo/resources/master/japan.jpg'),
  Location(
      name: 'Manarola',
      imageUrl:
          'https://raw.githubusercontent.com/mivoligo/resources/master/italy.jpg')
];

List mainMenu = [
  'Trending',
  'Africa',
  'America',
  'Asia',
  'Australia',
  'Europe',
];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discover',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class LocationListTile extends StatelessWidget {
  final String title;
  final String description;

  const LocationListTile({
    Key key,
    this.title,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: [
                BoxShadow(
                    color: Color(0x33000000),
                    offset: Offset(0.0, 5.0),
                    blurRadius: 12.0),
              ],
            ),
          ),
          Column(
            children: [
              Text(title),
              Text(description),
            ],
          )
        ],
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double _appWidth;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    _appWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Discover',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(
              Icons.account_circle,
              color: Colors.black87,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Column(
            children: [
              Container(
                height: 20,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mainMenu.length,
                    itemBuilder: (context, index) => FlatButton(
                          child: Text(
                            mainMenu[index],
                            style: TextStyle(
                                color: index == 0
                                    ? Colors.deepPurple[800]
                                    : Colors.grey,
                                fontSize: 16.0),
                          ),
                          onPressed: () {
                            print('$index');
                          },
                        )),
              ),
              Container(
                height: _appWidth * 0.6,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: featuredLocations.length,
                  itemBuilder: (context, index) => FeaturedCard(
                    text: featuredLocations[index].name,
                    imageUrl: featuredLocations[index].imageUrl,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class FeaturedCard extends StatelessWidget {
  final String text;
  final String imageUrl;

  const FeaturedCard({
    Key key,
    this.text,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AspectRatio(
        aspectRatio: 3 / 2,
        child: Card(
          color: Colors.lightBlue,
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageUrl),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      end: Alignment.topCenter,
                      begin: Alignment.bottomCenter,
                      colors: [Color(0x99000000), Colors.transparent])),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                    Row(children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 16.0,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 16.0,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 16.0,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 16.0,
                      ),
                      Icon(
                        Icons.star_half,
                        color: Colors.yellow,
                        size: 16.0,
                      ),
                      Text(
                        '4.2',
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                      )
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
