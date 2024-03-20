
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class GroupList extends StatelessWidget{

  List _elements;
  GroupList(this._elements );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GroupedListView<dynamic, String>(
        elements: _elements,
        useStickyGroupSeparators: true,

        groupBy: (element) => element['group'],
        groupSeparatorBuilder: (String value) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        itemBuilder: (c, element){
          return Card(
            elevation: 8.0,
            margin:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: SizedBox(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                leading: const Icon(Icons.account_circle),
                title: Text(element['name'],
                style: TextStyle(color: Colors.black)),
                trailing: const Icon(Icons.arrow_forward),
              ),
            ),
          );
        },

      ),
    );
  }

}