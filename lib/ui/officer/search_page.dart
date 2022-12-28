import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController editingController = TextEditingController();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 5.0,
          ),
          child: TextField(
            controller: editingController,
            onChanged: (value) {},
            decoration: const InputDecoration(
              labelText: "Search",
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(index.toString()),
              );
            },
          ),
        ),
      ],
    );
  }
}
