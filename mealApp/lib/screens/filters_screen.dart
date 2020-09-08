import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {

  static const String routeName = "/filters";

  final Function saveFilters;
  final Map<String,bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {

  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    _lactoseFree = widget.currentFilters['lactose'];
    super.initState();
  }

  Widget buildSwitchTile(String title, String subtitle, bool value, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: updateValue,
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Filters"),
      actions: [
        IconButton(icon: Icon(Icons.save), onPressed: (){
          final selectedFilters = {
            'gluten': _glutenFree,
            'lactose': _lactoseFree,
            'vegan': _vegan,
            'vegetarian': _vegetarian
          };
          widget.saveFilters(selectedFilters);
        },)
      ],),
      body: Container(
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text("Adjust your meal selection."),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchTile("Gluten-free", "Only include gluten-free meals", _glutenFree, (val) {
                  setState(() {
                    _glutenFree = val;
                  });
                }),
                buildSwitchTile("Vegetarian", "Only include veggie meals", _vegetarian, (val) {
                  setState(() {
                    _vegetarian = val;
                  });
                }),
                buildSwitchTile("Lactose-free", "Only include lactose-free meals", _lactoseFree, (val) {
                  setState(() {
                    _lactoseFree = val;
                  });
                }),
                buildSwitchTile("Vegan", "Only include vegan meals", _vegan, (val) {
                  setState(() {
                    _vegan = val;
                  });
                }),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
