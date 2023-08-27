import 'package:flutter/material.dart';
import 'package:pokecode/widgets/popup_filters.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final int currentIndex;
  final String valorInput;
  final List filtroEValorAppBar;
  final ValueChanged<String> onInputChanged;
  final ValueChanged<List> onPopupChanged;

  MyAppBar(
      {required this.currentIndex,
      required this.valorInput,
      required this.onInputChanged,
      required this.onPopupChanged,
      required this.filtroEValorAppBar});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.valorInput);
// Copiar os elementos da lista
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 45,
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onSubmitted: (newValue) {
                      setState(() {
                        _controller.text = newValue;
                      });
                      widget.onInputChanged(newValue);
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () async {
                      final filtroEValorNovo = await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const PopupFilter();
                        },
                      );
                      if (filtroEValorNovo != null) {
                        setState(() {});
                      }
                      widget.onPopupChanged(filtroEValorNovo);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(12),
                    ),
                    child: const Icon(Icons.search, color: Colors.white),
                  ),
                ),
              ],
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
