import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;

  const MyAppBar({required this.currentIndex});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/app_vazado_icon.png',
            width: 40,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              height: 40,
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
          ),
          const ProfileButton(),
        ],
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  const ProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60, 
      child: InkWell(
        child: IconButton(
          icon: Image.asset('assets/images/user_icon.png'),
          onPressed: () {
            Navigator.pushNamed(context, '/profile');
          },
        ),
      ),
    );
  }
}
