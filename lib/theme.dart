import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  late BuildContext context;
  AppTheme({required this.context});
  Map<String, dynamic> get colors {
    return {
      "bgWhite": Color(0xFFFFFFFF),
      "grey2": Colors.grey.shade400,
      "primary": Theme.of(context).colorScheme.primary,
      "red": Colors.redAccent,
      "secondary": Colors.deepOrange,
      "light": const Color(0xffd8f5e7),
      'boxShadow': Color(0xffA4A4A4),
      'greenAccentLight2': Color(0xff5EB336),
      'bgLightGrey': Color(0xffE6F0FF),
      "foreground": Color(0xFFE6F0FF),
      "bgNavy": Color(0xFF112752),
      "bgWhite": Color(0xFFFFFFFF),
      "red": Color(0xFFEB1A3C),
      "maroon": Color(0xFFAB17F1),
      "boxShadow": Color(0xFFA4A4A4),
      "bgLightGrey": Color(0xFFE6F0FF),
      "grey": Colors.grey,
      "grey2": Colors.grey.shade400,
      "grey1": Colors.grey.shade200,
      "blackLight": Colors.black54,
      "green": Colors.green,
      "greenAccent": Colors.greenAccent,
      "greenAccentLight": Color(0xFF7EC15E),
      "greenAccentLight2": Color(0xFF5EB336),
      "purple": Color(0xFF6200EE),
      "orange": Color(0xFFEB1A3C),
    };
  }

  Map<String, dynamic> get textTheme {
    return {
      "light": Theme.of(context).textTheme.bodySmall,
      "appBarTitle": Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Colors.white,
          ),
      "titleLargeBold": Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.w500),
      "titleLargeBoldColor": Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.bold, color: colors['primary']),
      "titleLargeBoldRed": Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.bold, color: Colors.red),
      "titleLargeBoldWhite": Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
      "titleLargeWhite":
          Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
      "titleMediumWhite": Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: Colors.white),
      "titleMediumBoldWhite": Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: Colors.white,fontWeight: FontWeight.w400),
      "titleLargeBold": Theme.of(context)
          .textTheme
          .headlineMedium
          ?.copyWith(fontWeight: FontWeight.w600,color:Colors.black),
      "titleMediumWhiteShadow": Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: Colors.white),
      "titleMediumWhiteBoldShadow": Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      "titleSmallWhiteBold": Theme.of(context)
          .textTheme
          .titleSmall
          ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
      "titleSmallGrey":
          Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey),
      "titleMediumBold": Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.bold),
      "titleMediumBoldBlack": Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black54),
      "titleMediumBoldColor": Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.w500, color: colors['primary']),
      "titleMediumBoldRed": Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.w500, color: Colors.red),
      "titleMediumBlackLight": Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.w500, color: Colors.black12),
      "titleMediumBlackLessDark": Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.w500, color: Colors.black45),
      "titleMediumWhiteBold": Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
      "titleSmallBoldColor": Theme.of(context)
          .textTheme
          .titleSmall
          ?.copyWith(fontWeight: FontWeight.w500, color: colors['primary']),
      "titleSmallDarkGrey": Theme.of(context)
          .textTheme
          .titleSmall
          ?.copyWith(fontWeight: FontWeight.bold, color: Color(0xff7B7B7B)),
      "titleSmallBlack": Theme.of(context)
          .textTheme
          .titleSmall
          ?.copyWith(fontWeight: FontWeight.bold, color: Color(0xff292929)),
      "titleLargeWhiteBold": Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
      "headingSmallBlack": Theme.of(context)
          .textTheme
          .headlineSmall
          ?.copyWith(fontWeight: FontWeight.bold, color: Color(0xff292929)),
      "headingSmallNuniBlack": Theme.of(context)
          .textTheme
          .headlineSmall
          ?.copyWith(color: Color(0xff292929), fontWeight: FontWeight.bold),
      "titleLargeBlack": Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black87),
      "titleMediumBoldWhite": Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
      "titleSmall": Theme.of(context).textTheme.titleSmall,
      "titleSmallBold": Theme.of(context)
          .textTheme
          .titleSmall
          ?.copyWith(fontWeight: FontWeight.bold),
      "titleSmallBoldOrange": Theme.of(context)
          .textTheme
          .titleSmall
          ?.copyWith(fontWeight: FontWeight.bold, color: colors['secondary']),
      "bodySmallBold": Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(fontWeight: FontWeight.bold),
      "bodySmallOrange": Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(color: colors['secondary']),
      "labelSmallBoldOrange": Theme.of(context)
          .textTheme
          .labelSmall
          ?.copyWith(fontWeight: FontWeight.bold, color: colors['secondary']),
      "bodySmallBlack":
          Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.black),
      "bodySmallWhite":
          Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
      "bodySmallBoldColor":
          Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight:FontWeight.w500,color: colors['primary']),

      "bodyLarge": Theme.of(context).textTheme.bodyLarge,
      "bodyMediumBold": Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(fontWeight: FontWeight.bold),
      "bodyMediumLight": Theme.of(context).textTheme.bodyMedium,
      "bodyMediumBoldColor": Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(fontWeight: FontWeight.w500, color: colors['primary']),
      "titleMediumBlackBold": Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.black,
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
          ),
      "bodyMediumBoldWhite": Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
      "titleMediumRedBold": Theme.of(context).textTheme.titleMedium?.copyWith(
            color: colors['secondary'],
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
          ),
      "bodyMediumRedBold": Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: colors['secondary'],
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
          ),
      "bodyLargeBold": Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(fontWeight: FontWeight.bold),
      "bodyLargeBoldColor": Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(fontWeight: FontWeight.bold,color:colors['primary']),
      "bodyLargeBoldColorUnderline": Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(fontWeight: FontWeight.bold,color:colors['primary'],decoration: TextDecoration.underline),
      "bodyLargeBoldBlack": Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black87),
      "bodyMediumWhite":
          Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
      "bodyMediumColor": Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: colors['primary']),
      "bodyMediumBoldColor": Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: colors['primary'], fontWeight: FontWeight.w500),
      "titleMediumColor": Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: colors['primary'], fontWeight: FontWeight.bold),
      "titleSmallGreenBold": Theme.of(context).textTheme.titleSmall?.copyWith(
            color: colors['primary'],
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
          ),
      "titleSmallDarkGreenBold":
          Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Colors.green.shade700,
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
              ),
      "titleSmallDarkGreen":
      Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Colors.green.shade700,
        fontFamily: 'Nunito',
        fontWeight: FontWeight.w500,
      ),

      "thinColor": Theme.of(context)
          .textTheme
          .labelLarge
          ?.copyWith(fontWeight: FontWeight.w500, color: colors['primary']),
    };
  }
}
