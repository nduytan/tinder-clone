import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tinder_app_clone/models/user_detail.dart';
import 'package:tinder_app_clone/models/user_general_information.dart';
import 'package:tinder_app_clone/provider/list_liked_provider.dart';
import 'package:tinder_app_clone/provider/position_card_provider.dart';
import 'package:tinder_app_clone/theme/colors.dart';
import 'package:badges/badges.dart';
import 'package:tinder_app_clone/widget/buildBadge.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

const List item_icons = [
  {
    "icon": "assets/images/refresh_icon.svg",
    "size": 45.0,
    "icon_size": 20.0,
    'id': 1
  },
  {
    "icon": "assets/images/close_icon.svg",
    "size": 58.0,
    "icon_size": 25.0,
    'id': 2
  },
  {
    "icon": "assets/images/star_icon.svg",
    "size": 45.0,
    "icon_size": 25.0,
    'id': 3
  },
  {
    "icon": "assets/images/like_icon.svg",
    "size": 57.0,
    "icon_size": 27.0,
    'id': 4
  },
  {
    "icon": "assets/images/thunder_icon.svg",
    "size": 45.0,
    "icon_size": 17.0,
    'id': 5
  }
];

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {
  CardController controller;
  var swipingDirection = SwipingDirection.none;

  List<UserGeneralInformation> listUserGeneralInformation = [];
  List<UserDetail> listUserDetail = [];

  Future userGeneralInformations;

  Future<List<UserDetail>> fetchUserGeneral() async {
    var headers = {'app-id': '62144fb0ab0208fdf539f462'};
    var url_1 = "https://dummyapi.io/data/v1/user?limit=10";

    var response = await http.get(Uri.parse(url_1), headers: headers);

    if (response.statusCode == 200) {
      var listUser = json.decode(response.body);
      for (var i in listUser['data']) {
        UserGeneralInformation user = UserGeneralInformation.fromJson(i);
        var url_2 = "https://dummyapi.io/data/v1/user/${user.id}";
        var resp = await http.get(Uri.parse(url_2), headers: headers);

        if (resp.statusCode == 200) {
          var item = json.decode(resp.body);
          UserDetail userDetail = UserDetail.fromJson(item);
          listUserDetail.add(userDetail);
        }
      }

      return listUserDetail;
    } else {
      print(response.statusCode);
      return listUserDetail;
    }
  }

  List itemsTemp = [];
  int itemLength = 0;
  int activeCard = 0;
  @override
  void initState() {
    userGeneralInformations = fetchUserGeneral();

    super.initState();
    setState(() {
      swipingDirection = SwipingDirection.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final positionCardProvider = Provider.of<PositionCardProvider>(context);
    final listLikedProvider = Provider.of<ListLikedProvider>(context);

    return Container(
        color: white,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                )),
            Padding(
              padding: const EdgeInsets.only(top: 84),
              child: SizedBox(
                  height: size.height,
                  child: FutureBuilder<List<UserDetail>>(
                    future: userGeneralInformations,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<UserDetail>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: Lottie.asset(
                          'assets/lottie/loading.json',
                          fit: BoxFit.fill,
                          frameRate: FrameRate(120),
                          reverse: true,
                          repeat: true,
                          width: MediaQuery.of(context).size.width / 5,
                        ));
                      } else {
                        if (snapshot.hasError) {
                          return const Center(child: Text('Lỗi kết nối'));
                        } else {
                          return TinderSwapCard(
                            stackNum: 2,
                            swipeEdge: 7,
                            orientation: AmassOrientation.BOTTOM,
                            totalNum: snapshot.data.length,
                            maxWidth: MediaQuery.of(context).size.width,
                            maxHeight: MediaQuery.of(context).size.height * 0.8,
                            minWidth: MediaQuery.of(context).size.width * 0.9,
                            minHeight: MediaQuery.of(context).size.height * 0.7,
                            cardBuilder: (context, index) => Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: grey.withOpacity(0.3),
                                        blurRadius: 5,
                                        spreadRadius: 2),
                                  ]),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: size.width,
                                      height: size.height,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                              black.withOpacity(1),
                                              black.withOpacity(0),
                                            ],
                                            end: Alignment.topCenter,
                                            begin: Alignment.bottomCenter),
                                        // image: DecorationImage(
                                        //     image: AssetImage(
                                        //         itemsTemp[index]['img']),
                                        //     fit: BoxFit.cover),
                                      ),
                                      child: Image.network(
                                        snapshot.data[index].picture,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    activeCard == index &&
                                            swipingDirection !=
                                                SwipingDirection.none
                                        ? buildLikeBadge(
                                            swipingDirection,
                                            positionCardProvider
                                                .getCardPosition())
                                        : Container(),
                                    Positioned(
                                        bottom: 0,
                                        child: Container(
                                          width: size.width,
                                          height: size.height / 2.5,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              gradient: LinearGradient(
                                                  begin: FractionalOffset
                                                      .topCenter,
                                                  end: FractionalOffset
                                                      .bottomCenter,
                                                  colors: [
                                                    Colors.grey
                                                        .withOpacity(0.0),
                                                    Colors.black,
                                                  ],
                                                  stops: const [
                                                    0.0,
                                                    3.0,
                                                  ])),
                                        )),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 100),
                                        child: SizedBox(
                                          width: size.width,
                                          height: size.height,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: size.width * 0.72,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Text(
                                                                snapshot
                                                                        .data[
                                                                            index]
                                                                        .firstName +
                                                                    " " +
                                                                    snapshot
                                                                        .data[
                                                                            index]
                                                                        .lastName,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: const TextStyle(
                                                                    color:
                                                                        white,
                                                                    fontSize:
                                                                        24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                snapshot
                                                                    .data[index]
                                                                    .age
                                                                    .toString(),
                                                                //activeCard.toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  color: white,
                                                                  fontSize: 22,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Container(
                                                                width: 10,
                                                                height: 10,
                                                                decoration: const BoxDecoration(
                                                                    color:
                                                                        green,
                                                                    shape: BoxShape
                                                                        .circle),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              const Text(
                                                                "Recently Active",
                                                                style:
                                                                    TextStyle(
                                                                  color: white,
                                                                  fontSize: 16,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                            height: 15,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: SizedBox(
                                                        width: size.width * 0.2,
                                                        child: const Center(
                                                          child: Icon(
                                                            Icons.info,
                                                            color: white,
                                                            size: 28,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            cardController: controller = CardController(),
                            swipeUpdateCallback:
                                (DragUpdateDetails details, Alignment align) {
                              /// Get swiping card's alignment
                              //print(align);
                              if (align.x < 0) {
                                positionCardProvider
                                    .setCardPosition(SwipingDirection.left);
                                setState(() {
                                  swipingDirection = SwipingDirection.left;
                                });
                                //Card is LEFT swiping
                              } else if (align.x > 0) {
                                positionCardProvider
                                    .setCardPosition(SwipingDirection.right);
                                setState(() {
                                  swipingDirection = SwipingDirection.right;
                                });
                                //Card is RIGHT swiping
                              }
                            },
                            swipeCompleteCallback:
                                (CardSwipeOrientation orientation, int index) {
                              positionCardProvider
                                  .setCardPosition(SwipingDirection.none);
                              setState(() {
                                swipingDirection = SwipingDirection.none;
                              });
                              if (orientation == CardSwipeOrientation.RIGHT) {
                                listLikedProvider
                                    .addUserToList(snapshot.data[index]);
                              }
                              if (orientation != CardSwipeOrientation.RECOVER) {
                                setState(() {
                                  activeCard = index + 1;
                                });
                              }
                              if (index == (itemsTemp.length - 1)) {
                                setState(() {
                                  itemLength = itemsTemp.length - 1;
                                });
                              }
                            },
                          );
                        }
                      }
                    },
                  )),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(item_icons.length, (index) {
                        return Container(
                          width: item_icons[index]['size'],
                          height: item_icons[index]['size'],
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: white,
                                width: 0.5,
                              ),
                              shape: BoxShape.circle,
                              color: swipingDirection != SwipingDirection.none
                                  ? (swipingDirection ==
                                              SwipingDirection.left &&
                                          item_icons[index]['id'] == 2
                                      ? Colors.white
                                      : swipingDirection ==
                                                  SwipingDirection.right &&
                                              item_icons[index]['id'] == 4
                                          ? Colors.white
                                          : Colors.transparent)
                                  : Colors.transparent,
                              boxShadow: [
                                BoxShadow(
                                  color: grey.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  // changes position of shadow
                                ),
                              ]),
                          child: Center(
                            child: SvgPicture.asset(
                              item_icons[index]['icon'],
                              width: item_icons[index]['icon_size'],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                )),
          ],
        )

        //bottomSheet: getBottomSheet(),
        );
  }

  // Widget getBody() {
  //   var size = MediaQuery.of(context).size;

  //   return ;
  // }

  Widget getBottomSheet() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 120,
      decoration: const BoxDecoration(color: white),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(item_icons.length, (index) {
            return Container(
              width: item_icons[index]['size'],
              height: item_icons[index]['size'],
              color: Colors.red,
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                  color: grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 10,
                  // changes position of shadow
                ),
              ]),
              child: Center(
                child: SvgPicture.asset(
                  item_icons[index]['icon'],
                  width: item_icons[index]['icon_size'],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
