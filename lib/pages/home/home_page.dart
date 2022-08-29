import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/blend_mask.dart';
import '../../controller/cursor_position_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cursorPositionController = Get.put(CursorPositionController());
  late final scrollController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MouseRegion(
        onEnter: (e) {
          Get.find<CursorPositionController>().isHover.value = true;
        },
        onHover: (e) {
          Get.find<CursorPositionController>().updatePosition(e.position);
        },
        onExit: (e) {
          Get.find<CursorPositionController>().isHover.value = false;
        },
        child: Stack(
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
            // github
            hiddenButton(
              'assets/github_icon.png',
              'https://github.com/dimassdoubles',
              15 / 100 * MediaQuery.of(context).size.height,
              Random().nextInt(MediaQuery.of(context).size.width.toInt() - 50),
            ),
            // linkedin
            hiddenButton(
              'assets/linkedin_icon.png',
              'https://www.linkedin.com/in/dimassdoubles',
              MediaQuery.of(context).size.height -
                  (30 / 100 * MediaQuery.of(context).size.height),
              Random().nextInt(MediaQuery.of(context).size.width.toInt() - 50),
            ),
            // instagram
            hiddenButton(
              'assets/instagram_icon.png',
              'https://www.instagram.com/dimassdoubles',
              MediaQuery.of(context).size.height -
                  (15 / 100 * MediaQuery.of(context).size.height),
              Random().nextInt(MediaQuery.of(context).size.width.toInt() - 50),
            ),
          ],
        ),
      ),
    );
  }

  follower() {
    return GetX<CursorPositionController>(
      init: CursorPositionController(),
      builder: (controller) => AnimatedPositioned(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.elasticOut,
        top: controller.dy - 100,
        left: controller.dx - 100,
        child: BlendMask(
          blendMode: BlendMode.difference,
          child: Padding(
            padding: const EdgeInsets.all(24),
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

  hiddenButton(String icon, String link, num top, num right) {
    return Positioned(
      top: top.toDouble(),
      left: right.toDouble(),
      child: InkWell(
        onTap: () {
          // html.window.open(link, "_blank");
        },
        child: SizedBox(
          width: 50,
          child: Image.asset(icon),
        ),
      ),
    );
  }
}
