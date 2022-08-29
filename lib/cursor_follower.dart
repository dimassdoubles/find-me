import 'package:find_me/blend_mask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:html' as html;
import 'dart:math';

class CursorFollower extends StatefulWidget {
  const CursorFollower({Key? key}) : super(key: key);

  @override
  State<CursorFollower> createState() => _CursorFollowerState();
}

class _CursorFollowerState extends State<CursorFollower> {
  bool isHover = false;
  Offset cursorPosition = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) {
        setState(() {
          isHover = true;
        });
      },
      onHover: (e) {
        setState(() {
          cursorPosition = e.position;
        });
      },
      onExit: (e) {
        setState(() {
          isHover = false;
        });
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            const Center(
              child: Text(
                'Find Me!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 128,
                ),
              ),
            ),
            follower(),
            // top right
            hiddenButton(
              'assets/github_icon.png',
              'https://github.com/dimassdoubles',
              15 / 100 * MediaQuery.of(context).size.height,
              MediaQuery.of(context).size.width -
                  (45 / 100 * MediaQuery.of(context).size.height),
            ),
            // bottom right
            hiddenButton(
              'assets/linkedin_icon.png',
              'https://www.linkedin.com/in/dimassdoubles',
              MediaQuery.of(context).size.height -
                  (30 / 100 * MediaQuery.of(context).size.height),
              MediaQuery.of(context).size.width -
                  (15 / 100 * MediaQuery.of(context).size.height),
            ),
            // bottom left
            hiddenButton(
              'assets/instagram_icon.png',
              'https://www.instagram.com/dimassdoubles',
              MediaQuery.of(context).size.height - 125,
              25 / 100 * MediaQuery.of(context).size.height,
            ),
          ],
        ),
      ),
    );
  }

  follower() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.elasticOut,
      top: cursorPosition.dy - 100,
      left: cursorPosition.dx - 100,
      child: BlendMask(
        blendMode: BlendMode.difference,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Visibility(
            visible: isHover ? true : false,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.7),
                    blurRadius: 15,
                  ),
                ],
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ),
      ),
    );
  }

  hiddenButton(String icon, String link, double top, double right) {
    return Positioned(
      top: top,
      left: right,
      child: InkWell(
        onTap: () {
          html.window.open(link, "_blank");
        },
        child: SizedBox(
          width: 50,
          child: Image.asset(icon),
        ),
      ),
    );
  }
}
