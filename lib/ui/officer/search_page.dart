import 'package:agriclaim/ui/constants/colors.dart';
import 'package:agriclaim/models/claim.dart';
import 'package:agriclaim/providers/claim_provider.dart';
import 'package:agriclaim/ui/farmer/claims_list_page.dart';
import 'package:agriclaim/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

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
        AsyncValue<List<Claim>> claimsList = ref.watch(searchResultsProvider);

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
                data: (searchResults) {
                  List<Claim> filteredResults = filterSearchResults(
                      searchResults, editingController.text);
                  return editingController.text.isEmpty
                      ? const SizedBox()
                      : filteredResults.isNotEmpty
                          ? SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(height: 5.h),
                                  for (final claim in filteredResults)
                                    ClaimInfoCard(claim: claim)
                                ],
                              ),
                            )
                          : Text(
                              "No valid search results",
                              style: TextStyle(
                                fontSize: 2.2.h,
                                color: AgriClaimColors.tertiaryColor,
                              ),
                            );
                  // return Text(data.toString());
                },
                error: (e, st) {
                  return Text(
                    "Failed to load search results",
                    style: TextStyle(
                      fontSize: 2.h,
                      color: AgriClaimColors.warningRedColor,
                    ),
                  );
                },
                loading: () =>
                    const Center(child: CircularProgressIndicator())),
          ],
        );
      },
    );
  }
}
