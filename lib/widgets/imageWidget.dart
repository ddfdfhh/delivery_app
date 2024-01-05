import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget CachedImageWidget(BuildContext context,String url,double? width,double? height,BoxFit? fit){
  return CachedNetworkImage(
    fit: fit!=null?fit:BoxFit.fill,
    width:width,height:height,
    imageUrl: Uri.encodeFull(url),
    placeholder: (context, url) =>
        Center(child: const CircularProgressIndicator()),
    errorWidget: (context, url, error) =>
        Image.asset('${assetUrl(context)}/no-image.jpg'),
  );
}