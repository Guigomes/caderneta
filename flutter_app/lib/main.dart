import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:firebase_database/firebase_database.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: RandomWords()
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {

  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);


  Widget _buildSuggestions(){
    final notesReference = FirebaseDatabase.instance.reference().child('notes');
    notesReference.push().set({
      'title': 'grokonez.com',
      'description': 'Programming Tutorials'
    }).then((_) {
      // ...
    });
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i){
          if(i.isOdd) return Divider();

          final index = i ~/2;
          if(index >= _suggestions.length){
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair){
    return ListTile(
      title: Text(pair.asCamelCase,
      style: _biggerFont

      )

    );

  }
  // TODO Add build() method
  @override
  Widget build(BuildContext context) {

    Choice _selectedChoice = choices[0]; // The app's "state".

    void _select(Choice choice) {
      // Causes the app to rebuild with the new _selectedChoice.
      setState(() {
        _selectedChoice = choice;
        _askedToLead();
      });
    }
    return Scaffold(
      appBar: AppBar(title: Text('Caderneta'),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(choices[0].icon),
            onPressed: () {
              _select(choices[0]);
            },
          )],
      ),
      body: _buildSuggestions()

    );
  }

    Future<void> _askedToLead() async {
      switch (await showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: const Text('Select assignment'),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () { Navigator.pop(context, choices[0].title); },
                  child: const Text('Treasury department'),
                ),
                SimpleDialogOption(
                  onPressed: () { Navigator.pop(context, choices[0].title); },
                  child: const Text('State department'),
                ),
              ],
            );
          }
      )) {
        case "1":
        // Let's go.
        // ...
          break;
        case "2":
        // ...
          break;
      }
    }

}


class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Car', icon: Icons.add),
  const Choice(title: 'Bicycle', icon: Icons.directions_bike),
  const Choice(title: 'Boat', icon: Icons.directions_boat),
  const Choice(title: 'Bus', icon: Icons.directions_bus),
  const Choice(title: 'Train', icon: Icons.directions_railway),
  const Choice(title: 'Walk', icon: Icons.directions_walk),
];
