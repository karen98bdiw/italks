import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final ValueChanged<int> onChanged;
  final int curentIndex;

  BottomNavigation({
    this.onChanged,
    this.curentIndex,
  });

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.04,
        ),
        color: Color.fromRGBO(255, 255, 255, 0.6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BottomNavItem(
              onPressed: (value) => widget.onChanged(value),
              curentIndex: widget.curentIndex,
              index: 0,
              checkedAsset: "assets/icons/cMess.png",
              unCheckedAsset: "assets/icons/uMess.png",
            ),
            BottomNavItem(
              onPressed: (value) => widget.onChanged(value),
              curentIndex: widget.curentIndex,
              index: 1,
              checkedAsset: "assets/icons/cPeople.png",
              unCheckedAsset: "assets/icons/uPeople.png",
            ),
            BottomNavItem(
              onPressed: (value) => widget.onChanged(value),
              curentIndex: widget.curentIndex,
              index: 2,
              checkedAsset: "assets/icons/cDisc.png",
              unCheckedAsset: "assets/icons/uDisc.png",
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final String checkedAsset;
  final String unCheckedAsset;
  final int index;
  final int curentIndex;
  final ValueChanged<int> onPressed;
  BottomNavItem(
      {this.checkedAsset,
      this.curentIndex,
      this.index,
      this.unCheckedAsset,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        child: Image.asset(
          index == curentIndex ? checkedAsset : unCheckedAsset,
          width: 40,
          height: 40,
        ),
      ),
    );
  }
}
