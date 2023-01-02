import 'package:agriclaim/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/claim_provider.dart';

class SearchPage extends ConsumerWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController editingController = TextEditingController();
    var claimList = ref.watch(searchClaimList(editingController.text));

    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 5.0,
        ),
        child: TextField(
          controller: editingController,
          onChanged: (value) {
            claimList = ref.refresh(searchClaimList(value));
          },
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
      claimList.when(
          data: (items) {
            return Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: AgriClaimColors.primaryColor,
                    )),
                    child: Text("Claim ID: ${items[index].claimId}"),
                  );
                },
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) => Center(child: Text(e.toString())))
    ]);
  }
}
