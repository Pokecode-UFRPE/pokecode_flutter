import 'package:flutter/material.dart';

class ExpanderFilters extends StatefulWidget {
  const ExpanderFilters({Key? key}) : super(key: key);

  @override
  State<ExpanderFilters> createState() => _ExpanderFiltersState();
}

class _ExpanderFiltersState extends State<ExpanderFilters> {
  final List<Item> _data = generateItems();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      elevation: 1,
      expandedHeaderPadding: EdgeInsets.all(0),
      animationDuration: Duration(milliseconds: 500),
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: Container(),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

class Item {
  Item({
    required this.headerValue,
    this.isExpanded = false,
  });

  String headerValue;
  bool isExpanded;
}

List<Item> generateItems() {
  return [
    Item(headerValue: 'Tipo'),
    Item(headerValue: 'Geração'),
    Item(headerValue: 'Formato'),
    Item(headerValue: 'Cor'),
    Item(headerValue: 'Raridade'),
  ];
}
