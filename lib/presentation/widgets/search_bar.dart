import 'package:auth_api/config/router/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  bool isEnglish = true;

  void changeLanguage() async{
    print(isEnglish);
    SharedPreferences prefs =
    await SharedPreferences.getInstance();
    isEnglish = await prefs.getBool("isEnglish") ?? true;
    setState(() {
      print("isEnglish $isEnglish");
      isEnglish = !isEnglish;
      print("Set state $isEnglish");
      prefs.setBool("isEnglish", isEnglish);
    });
    // await ;
    // Navigator.pushNamedAndRemoveUntil(context, AppRoutes.SIGNIN, (route) => false);
    print("fssss${prefs.getBool("isEnglish")}");
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: SizedBox(
                height: 50,
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    hintText: AppLocalizations.of(context)!.search,
                    prefixIcon: IconButton(
                      icon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            IconButton(onPressed: () {
              // SharedPreferences prefs =
              //     await SharedPreferences.getInstance();
              // prefs.setBool("isEnglish", isEnglish);
              changeLanguage();
            },
                icon: Icon(Icons.language_outlined,
                size: 35,color: Color.fromARGB(255, 16, 98, 92),
                ),
            ),
          ],
        )
    );
  }
}
