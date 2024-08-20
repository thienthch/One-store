import 'package:flutter/material.dart';
import 'package:one_store/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/model/product_model.dart';
import '../favourite/favoriteservice.dart';

class FavoriteButton extends StatefulWidget {
  final ProductModel product;

  const FavoriteButton({Key? key, required this.product}) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  void _loadFavoriteStatus() async {
    bool status =
        await FavoriteService.loadFavoriteStatus(widget.product.productid);
    print('Loaded favorite status for ${widget.product.name}: $status');
    setState(() {
      isFavorite = status;
    });
  }

  void _toggleFavorite() async {
    setState(() {
      isFavorite = !isFavorite;
    });

    print('Toggled favorite status for ${widget.product.name}: $isFavorite');

    await FavoriteService.saveFavoriteStatus(
        widget.product.productid, isFavorite);

    if (isFavorite) {
      favoriteProducts.add(widget.product);
      print('Added ${widget.product.name} to favorites');
    } else {
      favoriteProducts.remove(widget.product);
      print('Removed ${widget.product.name} from favorites');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color(0xFFEC8F5E),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: IconButton(
        icon: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
          color: Colors.white,
        ),
        onPressed: _toggleFavorite,
      ),
    );
  }
}
