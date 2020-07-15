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

class _MyHomePageState extends State<MyHomePage> {
  double _appWidth;
  double _appHeight;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    _appWidth = MediaQuery.of(context).size.width;
    _appHeight = MediaQuery.of(context).size.height;
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
        children: [
          MainMenu(),
          Container(
            height: _appWidth * 0.6,
            child: ListView.builder(
              scrollDirection:
                  _appWidth > _appHeight ? Axis.vertical : Axis.horizontal,
              itemCount: featuredLocations.length,
              itemBuilder: (context, index) => FeaturedCard(
                text: featuredLocations[index].name,
                imageUrl: featuredLocations[index].imageUrl,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        'Top Locations',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text('View All')
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: LocationListTile(
                              title: '$index',
                            ),
                          )),
                )
              ],
            ),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: mainMenu.length,
          itemBuilder: (context, index) => FlatButton(
                child: Text(
                  mainMenu[index],
                  style: TextStyle(
                      color: index == 0 ? Colors.deepPurple[800] : Colors.grey,
                      fontSize: 16.0),
                ),
                onPressed: () {
                  print('$index');
                },
              )),
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

class LocationListTile extends StatelessWidget {
  final String title;
  final String description;

  const LocationListTile({
    Key key,
    this.title,
    this.description =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
                color: Color(0x33000000),
                offset: Offset(0.0, 5.0),
                blurRadius: 12.0)
          ],
        ),
      ),
      title: Text(title),
      subtitle: Text(
        description,
        maxLines: 2,
      ),
    );
  }
}
