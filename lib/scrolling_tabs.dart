import 'package:flutter/material.dart';

class ScrollTabBar extends StatefulWidget {
  final List<TabItems>? tabList;
  final List<Widget>? widgetList;
  final count;
  final ValueChanged? returnTitle;

  final double? singleTabWidth;
  final ScrollTabBarStyle? style;

  ScrollTabBar({
    this.returnTitle,

    this.singleTabWidth = 100,
    required this.widgetList,
    this.style,
    required this.tabList,
    required this.count,
  });
  @override
  _ScrollTabBarState createState() => _ScrollTabBarState();
}

class _ScrollTabBarState extends State<ScrollTabBar> {
  var topHeader;
  var _currentPosition;
  var headerLoc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    topHeader = widget.tabList![0];
    _currentPosition = 0;

  }

  @override
  Widget build(BuildContext context) {
    headerLoc = widget.tabList![_currentPosition].label;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            ///TabBar
            widget.tabList!.length == widget.count
                ?  Container(

              color: widget.style!.backgroundColor,
              width: MediaQuery.of(context).size.width,
              height: 60,
              child:
              ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.tabList!.length,
                  itemBuilder: (con, index) {
                    return GestureDetector(
                      onTap: () => setState(() {
                        _currentPosition = index;
                        headerLoc = widget.tabList![_currentPosition].label;
                        // print('head:ta');
                        returnTitle();
                      }),
                      child: Padding(
                        padding: widget.style!.padding,
                        child: Container(
                            alignment: Alignment.center,
                            width: widget.singleTabWidth,
                            color: headerLoc == widget.tabList![index].label
                                ? widget.style!.activeColor
                                : Colors.transparent,
                            child:

                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    widget.tabList![index].label ?? 'null',
                                    style: TextStyle(
                                      color:
                                      headerLoc == widget.tabList![index].label
                                          ? widget.style!.activeTextColor
                                          : widget.style!.textColor,
                                      fontFamily: widget.style!.fontFamily,
                                      fontSize: widget.style!.textSize,
                                    ),
                                  ),
                                  const SizedBox(height: 1),
                                  widget.tabList![index].icon != null
                                      ? Icon(
                                    widget.tabList![index].icon,
                                    color: headerLoc ==
                                        widget.tabList![index].label
                                        ? widget.style!.activeIconColor
                                        : widget.style!.iconColor,
                                    size: widget.style!.iconSize,
                                  )
                                      : Container(),
                                ],
                              ),
                            )),
                      ),
                    );
                  }),

            )
                : Container(
              alignment: Alignment.center,
              child: Text(
                'count  must be equal to tabList length ${widget.tabList!.length}',
                style: TextStyle(color: Colors.red),
              ),
            ),

            ///Widget
            widget.tabList!.length == widget.count
                ? Expanded(
              child: GestureDetector(
                  onHorizontalDragEnd: (start) {
                    // print('start : ${start.velocity.pixelsPerSecond.dx}');
                    if ((start.velocity.pixelsPerSecond.dx) < -700) {
                      if (_currentPosition < widget.tabList!.length - 1 &&
                          _currentPosition >= 0) {
                        setState(() {
                          _currentPosition = (_currentPosition + 1);
                          // widget.currentPosition = widget.currentPosition+1;
                          // returnData(_currentPosition);
                        });
                        returnTitle();
                      }
                    } else {}

                    if ((start.velocity.pixelsPerSecond.dx) > 900) {
                      if (_currentPosition <=
                          widget.tabList!.length - 1 &&
                          _currentPosition > 0) {
                        setState(() {
                          _currentPosition = _currentPosition - 1;
                          headerLoc = widget.tabList![_currentPosition];

                        });

                        returnTitle();
                      }
                    }
                  },
                  child: applyWidget()),
            )
                : Container(
              alignment: Alignment.center,
              child: Text(
                'count must be equal to WidgetList length ${widget.widgetList!.length}',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget? applyWidget() {
    topHeader = widget.widgetList![_currentPosition];


    return widget.widgetList![_currentPosition];
  }
  returnTitle() {
    var callback = widget.returnTitle;
    if (callback != null) {
      setState(() {
        var a = widget.tabList![_currentPosition].label;

        callback(a);
      });
    }
  }
// list() {
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: Container(
//         child: Column(
//           children: [
//             for (var color in Colors.primaries)
//               Container(color: color, height: 100.0)
//           ],
//         ),
//       ),
//     );
//   }
//
//   grid() {
//     return GridView.count(
//       padding: EdgeInsets.zero,
//       crossAxisCount: 3,
//       children: Colors.primaries.map((color) {
//         return Container(color: color, height: 100.0);
//       }).toList(),
//     );
//   }
}

class ScrollTabBarStyle {
  ScrollTabBarStyle(
      {this.textSize = 14,
        this.iconSize,
        this.textColor = Colors.black,
        this.iconColor = Colors.black,
        this.backgroundColor = Colors.transparent,
        this.activeTextColor = Colors.grey,
        this.activeIconColor = Colors.grey,
        this.activeColor = Colors.black38,
        this.fontFamily,
        this.padding = const EdgeInsets.all(0)});
  final double? textSize;
  final double? iconSize;
  final Color? textColor;
  final Color? iconColor;
  final Color? activeIconColor;
  final Color? backgroundColor;
  final Color? activeColor;
  final Color? activeTextColor;
  final String? fontFamily;
  final EdgeInsetsGeometry padding;
// get t_Size=>textSize;
// get bg_color=>backgroundColor;
// get ac_color=>activeColor;
}

class TabItems {
  final IconData? icon;
  // final TextStyle? textStyle;
  // final double?  iconSize;
  // final Color? a;
  final String? label;
  TabItems({this.icon, this.label, this.activeLabel, this.tabStyle
    // this.iconSize,this.iconColor,this.textStyle
  });

  final ScrollTabBarStyle? tabStyle;
  final String? activeLabel;
}
