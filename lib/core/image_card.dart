import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ImageCard extends StatefulWidget {
  ImageCard(
      {super.key,
      this.liked = false,
      required this.imageURL,
      required this.imageTitle});

  bool liked;
  String imageURL;
  String imageTitle;

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> {
  bool isLiked = false;

  _likeImage() {
    setState(() {
      isLiked = !isLiked;
    });
    //do stuff to push to firebase or some database
  }

  @override
  void initState() {
    super.initState();
    isLiked = widget.liked;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Text(
              widget.imageTitle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          CachedNetworkImage(
            placeholder: (context, url) => const CircularProgressIndicator(),
            imageUrl: widget.imageURL,
            width: MediaQuery.of(context).size.width,
          ),
          Center(
            child: IconButton(
              onPressed: _likeImage,
              icon: Icon(
                Icons.favorite,
                color: isLiked ? Colors.red : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
