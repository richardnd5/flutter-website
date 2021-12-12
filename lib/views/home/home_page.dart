import 'package:flutter/material.dart';
import 'package:flutter_website/navigation/fade_page.dart';
import 'package:flutter_website/navigation/nav_router_delegate.dart';
import 'package:flutter_website/navigation/nav_state.dart';

import 'package:provider/provider.dart';
import 'home_page_view_model.dart';
import 'expanding_page_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey homeKey = GlobalKey();
  GlobalKey musicKey = GlobalKey();
  GlobalKey contactKey = GlobalKey();
  GlobalKey codingKey = GlobalKey();
  GlobalKey noKey = GlobalKey();

  Widget? selectedWidget;

  bool isAnimating = false;

  addPageToStack(BuildContext context, PageType type, Color color) async {
    PageConfig selectedPage;

    switch (type) {
      case PageType.coding:
        selectedPage = codingPageConfig;
        break;
      case PageType.about:
        selectedPage = aboutPageConfig;
        break;
      case PageType.music:
        selectedPage = musicPageConfig;
        break;
      case PageType.contact:
        selectedPage = contactPageConfig;
        break;
    }

    Provider.of<NavState>(context, listen: false).goTo(selectedPage);
    await Future.delayed(Duration(milliseconds: 800));
    _whenShrinkAnimFinished();
  }

  _handleSquareTap(
    BuildContext context,
    PageType type,
    Offset globalPos,
  ) {
    print(type);
    var size = MediaQuery.of(context).size;

    if (!isAnimating) {
      setState(() {
        isAnimating = true;
      });
      setState(() {
        selectedWidget = ExpandingPageContainer(
          startOffset: getPos(type.index),
          startSize: Size(size.width / 2, size.height / 2),
          shrinkFinished: _whenShrinkAnimFinished,
          animateFinished: () => addPageToStack(
            context,
            type,
            type.getPageColor(),
          ),
          color: type.getPageColor(),
          width: size.width,
        );
      });
    }
  }

  _whenShrinkAnimFinished() {
    setState(() {
      selectedWidget = null;
      isAnimating = false;
    });
  }

  GlobalKey getKey(int index) {
    if (index == 0) return homeKey;
    if (index == 1) return musicKey;
    if (index == 2) return contactKey;
    if (index == 3) return codingKey;
    return noKey;
  }

  Offset getPos(int index) {
    final RenderBox renderBox =
        getKey(index).currentContext!.findRenderObject() as RenderBox;
    print(renderBox.localToGlobal(Offset.zero));
    return renderBox.localToGlobal(Offset.zero);
  }

  Widget _buildBackground(BuildContext context) {
    var size = MediaQuery.of(context).size;

    List<Offset> offsetList = [
      Offset(0, 0),
      Offset(0, size.width / 2),
      Offset(size.height / 2, 0),
      Offset(size.height / 2, size.width / 2),
    ];
    return Stack(
      children: PageType.values
          .map(
            (e) => AnimatedPositioned(
              key: getKey(e.index),
              left: offsetList[e.index].dy,
              top: offsetList[e.index].dx,
              duration: Duration(milliseconds: 300),
              child: GestureDetector(
                onTapUp: (details) =>
                    _handleSquareTap(context, e, details.globalPosition),
                child: Container(
                  color: e.getPageColor(),
                  width: size.width / 2,
                  height: size.height / 2,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBackground(context),
        selectedWidget ?? Container(),
      ],
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_website/views/newHomePage/expandingHomePage2/home_page_square.dart';
// import 'package:provider/provider.dart';

// import 'expanding_home_page_view_model.dart';

// class ExpandingHomePage2 extends StatefulWidget {
//   const ExpandingHomePage2({Key? key}) : super(key: key);

//   @override
//   State<ExpandingHomePage2> createState() => _ExpandingHomePage2State();
// }

// class _ExpandingHomePage2State extends State<ExpandingHomePage2> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//       var size = MediaQuery.of(context).size;
//       print(size);
//       Provider.of<ExpandingHomePageViewModel>(context, listen: false)
//           .init(size);
//     });
//   }

//   _handleTap(BuildContext context, PageType type) {
//     Provider.of<ExpandingHomePageViewModel>(context, listen: false)
//         .handlePageTap(type);
//   }

//   List<Widget> _getList(BuildContext context) {
//     var size = MediaQuery.of(context).size;

//     var vm = context.watch<ExpandingHomePageViewModel>();
//     print('in get list $size');

//     List<Offset> offsetList = [
//       Offset(0, 0),
//       Offset(0, size.width / 2),
//       Offset(size.height / 2, 0),
//       Offset(size.height / 2, size.width / 2),
//     ];

//     return vm.pageList
//         .map(
//           (e) => AnimatedPositioned(
//             duration: Duration(milliseconds: 300),
//             top: e.enabled ? 0 : offsetList[e.order].dy,
//             left: e.enabled ? 0 : offsetList[e.order].dx,
//             child: GestureDetector(
//               onTap: () => _handleTap(context, e.type),
//               child: AnimatedContainer(
//                 duration: Duration(milliseconds: 300),
//                 color: e.color,
//                 width: size.width / 2, height: 200,

//                 // width: e.enabled ? size.width : size.width / 2,
//                 // height: e.enabled ? size.height : size.height / 2,
//               ),
//             ),
//           ),
//         )
//         .toList();
//     // return [
//     // AnimatedPositioned(
//     //   duration: Duration(milliseconds: 300),
//     //   top: 0,
//     //   left: 0,
//     //   child: GestureDetector(
//     //     onTap: () => _handleTap(context, PageType.about),
//     //     child: AnimatedContainer(
//     //       duration: Duration(milliseconds: 300),
//     //       color: Colors.blue,
//     //       width: page.enabled ? size.width : size.width / 2,
//     //       height: page.enabled ? size.height : size.height / 2,
//     //       // child: page.enabled ? page.page : null,
//     //     ),
//     //   ),
//     // ),
//     //   AnimatedPositioned(
//     //     duration: Duration(milliseconds: 300),
//     //     top: 0,
//     //     left: vm.pageList[0].enabled ? 0 : size.width / 2,
//     //     child: HomePageSquare(
//     //       size: size,
//     //       page: vm.pageList[1],
//     //       onTap: (type) => _handleTap(context, type),
//     //     ),
//     //   ),
//     //   AnimatedPositioned(
//     //     duration: Duration(milliseconds: 300),
//     //     top: vm.pageList[0].enabled ? 0 : size.height / 2,
//     //     left: 0,
//     //     child: HomePageSquare(
//     //       size: size,
//     //       page: vm.pageList[2],
//     //       onTap: (type) => _handleTap(context, type),
//     //     ),
//     //   ),
//     //   AnimatedPositioned(
//     //     duration: Duration(milliseconds: 300),
//     //     top: vm.pageList[0].enabled ? 0 : size.height / 2,
//     //     left: vm.pageList[0].enabled ? 0 : size.width / 2,
//     //     child: HomePageSquare(
//     //       size: size,
//     //       page: vm.pageList[3],
//     //       onTap: (type) => _handleTap(context, type),
//     //     ),
//     //   ),
//     // ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     var vm = context.watch<ExpandingHomePageViewModel>();

//     return Stack(
//       children: vm.pageList
//           .map(
//             (e) => AnimatedPositioned(
//               duration: Duration(milliseconds: 300),
//               top: e.enabled ? 0 : e.pos.dy,
//               left: e.enabled ? 0 : e.pos.dx,
//               child: GestureDetector(
//                 onTap: () => _handleTap(context, e.type),
//                 child: AnimatedContainer(
//                   duration: Duration(milliseconds: 300),
//                   color: e.color,
//                   width: size.width / 2, height: 200,

//                   // width: e.enabled ? size.width : size.width / 2,
//                   // height: e.enabled ? size.height : size.height / 2,
//                 ),
//               ),
//             ),
//           )
//           .toList(),
//     );
//   }
// }


// // import 'package:flutter/material.dart';
// // import 'package:flutter_website/home_page.dart';
// // import 'package:flutter_website/views/newHomePage/expandingHomePage2/expanding_home_page_view_model.dart';
// // import 'package:flutter_website/views/newHomePage/expandingHomePage2/home_page_square.dart';
// // import 'package:flutter_website/views/newHomePage/models/website_page.dart';
// // import 'package:provider/provider.dart';

// // class ExpandingHomePage2 extends StatelessWidget {
// //   const ExpandingHomePage2({Key? key}) : super(key: key);

// //   _handleTap(BuildContext context, PageType type) {
// //     Provider.of<ExpandingHomePageViewModel>(context, listen: false)
// //         .handlePageTap(type);
// //   }

// //   List<Widget> _getList(BuildContext context) {
// //     var size = MediaQuery.of(context).size;

// //     var vm = context.watch<ExpandingHomePageViewModel>();

// //     List<Widget> pageList = [];

// //     List<Offset> offsetList = [
// //       Offset(0, 0),
// //       Offset(0, size.width / 2),
// //       Offset(size.height / 2, 0),
// //       Offset(size.height / 2, size.width / 2),
// //     ];
// //     vm.pageList.asMap().forEach((i, element) {
// //       pageList.add(
// //         Positioned(
// //           top: offsetList[i].dy,
// //           left: offsetList[i].dx,
// //           child: HomePageSquare(
// //             size: size,
// //             page: element,
// //             onTap: (type) => _handleTap(context, type),
// //           ),
// //         ),
// //       );
// //     });

// //     return pageList;
// //     // return [
// //     //   Positioned(
// //     //     top: 0,
// //     //     left: 0,
// //     //     child: HomePageSquare(
// //     //       size: size,
// //     //       page: vm.pages[PageType.about]!,
// //     //       onTap: (type) => _handleTap(context, type),
// //     //     ),
// //     //   ),
// //     //   Positioned(
// //     //     top: 0,
// //     //     left: size.width / 2,
// //     //     child: HomePageSquare(
// //     //       size: size,
// //     //       page: vm.pages[PageType.music]!,
// //     //       onTap: (type) => _handleTap(context, type),
// //     //     ),
// //     //   ),
// //     //   Positioned(
// //     //     top: size.height / 2,
// //     //     left: 0,
// //     //     child: HomePageSquare(
// //     //       size: size,
// //     //       page: vm.pages[PageType.coding]!,
// //     //       onTap: (type) => _handleTap(context, type),
// //     //     ),
// //     //   ),
// //     //   Positioned(
// //     //     top: size.height / 2,
// //     //     left: size.width / 2,
// //     //     child: HomePageSquare(
// //     //       size: size,
// //     //       page: vm.pages[PageType.contact]!,
// //     //       onTap: (type) => _handleTap(context, type),
// //     //     ),
// //     //   ),
// //     // ];
// //   }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     body: Stack(
//   //       children: _getList(context),
//   //     ),
//   //   );
//   // }
// // }
