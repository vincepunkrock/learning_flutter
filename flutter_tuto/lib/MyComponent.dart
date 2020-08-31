import 'package:flutter/material.dart';

import 'question.dart';

class MyComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyComponentState();

}

class MyComponentState extends State<MyComponent> {

  final items = <String>["1", "2"];
  final savedItems = Set<String>();

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        //scrollDirection: Axis.vertical,
        //shrinkWrap: true,
        itemBuilder: (context, item) {
          if(item.isOdd) return Divider();
          final index = item ~/ 2;

          if(index >= items.length) {
            items.addAll(["a", "b", "c", "d"]);
          }
          return _buildRow(items[index]);
        }
    );
  }

  Widget _buildRow(String text) {
    final alreadySaved = savedItems.contains(text);
    return
        ListTile(
            title: Text(text, style: TextStyle
              (fontSize: 18.0)),
            trailing: Icon(alreadySaved ? Icons.favorite: Icons.favorite_border, color: Colors.red),
            onTap: () {
              setState(() {
                if(alreadySaved) {
                  savedItems.remove(text);
                }
                else{
                  savedItems.add(text);
                }
              });
            }
        );
  }

  void _pushSaved() {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (BuildContext context) {
              final Iterable<ListTile> tiles =
              savedItems.map((String text) {
                return ListTile(
                    title: Text(text)
                );
              });

              final List<Widget> divided = ListTile.divideTiles(
                context: context,
                tiles: tiles
              ).toList();
              return Scaffold(
                appBar: AppBar(
                  title: Text('Saved texts')
                ),
                body: ListView(children: divided)
              );

            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyComponent"),
          actions: <Widget> [
            IconButton(
                icon: Icon(Icons.list),
                onPressed: _pushSaved
            )
          ]
      ),
        body:
        Column(
          children: [
            Question("my question!", showMyDialog),
            Expanded(
              child: _buildList()
            )
          ],
        )
    );
  }

  showMyDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('You clicked on'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text('This is a Dialog Box. Click OK to Close.'),
              ],
            ),
          ),
          actions: [
            new FlatButton(
              child: new Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}