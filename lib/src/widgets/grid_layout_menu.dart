import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class GLMenuButton {
  @required
  final Function onPressed;
  @required
  final IconData icon;

  GLMenuButton({
    this.onPressed, this.icon});
}

class GridLayoutMenu extends StatelessWidget {

  final bool show;
  final Color backgroundColor;
  final Color activeColor;
  final Color inactiveColor;
  final List<GLMenuButton> items;


  GridLayoutMenu({
        this.show = true,
        this.backgroundColor = Colors.white, 
        this.activeColor = Colors.black,
        this.inactiveColor = Colors.blueGrey,
        @required this.items
  });


  // Builder Menu and Items
  @override
  Widget build(BuildContext context) {
  
      return ChangeNotifierProvider(
        create: (_) => new _MenuModel(),
        child: AnimatedOpacity(
          duration: Duration(milliseconds: 20),
          opacity: (show)? 1: 0,
          child: Builder(
            builder: (BuildContext context) {

              Provider.of<_MenuModel>(context).backgroundColor = this.backgroundColor;
              Provider.of<_MenuModel>(context).activeColor = this.activeColor;
              Provider.of<_MenuModel>(context).inactiveColor = this.inactiveColor;

              return GLMenuBackGround(
                child: _MenuItems( items )
              );
              })
          
          ),
        );
  
  }
}

class GLMenuBackGround extends StatelessWidget {

  final Widget child;

  const GLMenuBackGround({ @required this.child}) ;

  @override
  Widget build(BuildContext context) {

    Color backgroundColor = Provider.of<_MenuModel>(context).backgroundColor;
    
    return Container(

      child: child,
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(100)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
            spreadRadius: -5
          )
        ]
      ),
    );
  }
}

class _MenuItems extends StatelessWidget {


  final  List<GLMenuButton> menuItems;

  _MenuItems(this.menuItems);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: 
        List.generate(menuItems.length, (i) => _GridLayoutMenuButton(i, menuItems[i])
    
    ));
  }
}

class _GridLayoutMenuButton extends StatelessWidget {

 final int index;
 final GLMenuButton item;

 _GridLayoutMenuButton(this.index, this.item);

  @override
  Widget build(BuildContext context) {

    final intemSelected = Provider.of<_MenuModel>(context).itemSelected;

    final menuProvider = Provider.of<_MenuModel>(context);


    return GestureDetector(
        onTap: (){

          Provider.of<_MenuModel>(context, listen: false ).itemSelected = index;
          item.onPressed();
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
        child: Icon(
          item.icon,

          size: (intemSelected == index )? 35: 25,

          color: (intemSelected == index )? menuProvider.activeColor: menuProvider.inactiveColor,
          ),
      ),
    );
  }
}

class _MenuModel with ChangeNotifier {

  Color backgroundColor = Colors.white;
  Color activeColor = Colors.black;
  Color inactiveColor = Colors.blueGrey;

  int _itemSelected = 0;

  int get itemSelected => this._itemSelected;

   set itemSelected(int index) {
    this._itemSelected = index;
    notifyListeners();
   }
} 


