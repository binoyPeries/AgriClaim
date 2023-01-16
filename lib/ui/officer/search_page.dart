import 'package:agriclaim/ui/farmer/claims_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/claim_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        var claimsList = ref.watch(searchResultsProvider);

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 5.0,
              ),
              child: TextField(
                controller: editingController,
                onChanged: (text) {
                  setState(() {});
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
            claimsList.when(
                data: (data) {
                  return data
                              .where((element) => element.claimId
                                  .toLowerCase()
                                  .startsWith(
                                      editingController.text.toLowerCase()))
                              .length ==
                          1
                      ? ClaimInfoCard(claim: data[0])
                      : const Text("No valid search results");
                  // return Text(data.toString());
                },
                error: (e, st) {
                  return const Text("Failed to load search results");
                },
                loading: () => const CircularProgressIndicator()),
            // SubmissionButton(
            //   text: "Search",
            //   onSubmit: () {},
            //   afterSubmit: (context) {},
            // ),
          ],
        );
      },
    );
  }
}
