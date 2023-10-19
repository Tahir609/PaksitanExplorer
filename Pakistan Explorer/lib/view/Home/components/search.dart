import 'package:flutter/material.dart';
import 'package:travelhour/view/search/searchbar.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(
          () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const SearchBar();
                },
              ),
            );
          },
        );
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xffececec),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            children: const [
              Icon(
                Icons.search,
                color: Color(0xff757575),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Search Places',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff4d5760),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
