import 'package:flutter/material.dart';
import 'package:tinder_app_clone/models/user_detail.dart';
import 'package:tinder_app_clone/provider/list_liked_provider.dart';
import 'package:tinder_app_clone/theme/colors.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import 'package:flutter_svg/svg.dart';

class LikesPage extends StatefulWidget {
  @override
  _LikesPageState createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  @override
  Widget build(BuildContext context) {
    final listLikedProvider = Provider.of<ListLikedProvider>(context);
    List<UserDetail> listLiked = listLikedProvider.getListLikedProvider();
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: white,
        body: Column(
          children: [
            Container(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue.shade800,
                          child: const Text('T'),
                        ),
                        Row(
                          children: [
                            Badge(
                              badgeContent: Text(
                                listLikedProvider.count().toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              child: SvgPicture.asset(
                                "assets/images/explore_icon.svg",
                                width: 30,
                              ),
                            ),
                          ],
                        )
                      ],
                    ))),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 90),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          listLikedProvider.count().toString() + " Liked",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Top Picks",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: black.withOpacity(0.5)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    thickness: 0.8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: List.generate(listLiked.length, (index) {
                        return Container(
                          width: (size.width - 15) / 2,
                          height: 250,
                          child: Stack(
                            children: [
                              Container(
                                width: (size.width - 15) / 2,
                                height: 250,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.network(
                                  listLiked[index].picture,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                width: (size.width - 15) / 2,
                                height: 250,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                        colors: [
                                          black.withOpacity(0.25),
                                          black.withOpacity(0),
                                        ],
                                        end: Alignment.topCenter,
                                        begin: Alignment.bottomCenter)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, bottom: 8),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 8,
                                            height: 8,
                                            decoration: const BoxDecoration(
                                                color: grey,
                                                shape: BoxShape.circle),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            listLiked[index].firstName +
                                                " " +
                                                listLiked[index].lastName,
                                            style: const TextStyle(
                                              color: white,
                                              fontSize: 14,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  Widget getFooter() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 90,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Container(
              width: size.width - 70,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(colors: [yellow_one, yellow_two])),
              child: Center(
                child: Text("SEE WHO LIKES YOU",
                    style: TextStyle(
                        color: white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
