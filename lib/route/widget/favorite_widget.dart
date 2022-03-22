import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid_flutter/res/colors.dart';

class FavoriteWidget extends StatefulWidget {
  bool isFavorite = false;
  Widget? selectIcon;
  Widget? unselectIcon;
  ValueChanged<bool?>? onChanged;

  FavoriteWidget({Key? key, this.onChanged, this.selectIcon, this.unselectIcon})
      : super(key: key);

  @override
  State<FavoriteWidget> createState() {
    return _FavoriteWidget();
  }
}

class _FavoriteWidget extends State<FavoriteWidget> {

  bool isFavorite = false;
  Widget? selectIcon;
  Widget? unselectIcon;
  ValueChanged<bool?>? onChanged;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFavorite = widget.isFavorite;
    selectIcon = widget.selectIcon;
    unselectIcon = widget.unselectIcon;
    onChanged = widget.onChanged;
  }

  @override
  Widget build(BuildContext context) {
    return _buildFavoriteWidget(context);
  }

  Widget _buildFavoriteWidget(BuildContext context) {
    selectIcon ??= const Icon(Icons.favorite, color: Colors.redAccent);
    unselectIcon ??= const Icon(Icons.favorite, color: Colors.grey);

    Widget icon = isFavorite ? selectIcon! : unselectIcon!;
    return Container(
        child: InkWell(
          child: icon,
          onTap: (){
            setState(() {
              isFavorite = !isFavorite;
              onChanged?.call(isFavorite);
            });
          },
        ),
    );
  }

}
