import 'package:flutter/material.dart';
import 'package:pokecode/widgets/popup_filters.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final int currentIndex;
  final String valorInput;
  final List filtroEValorAppBar;
  final ValueChanged<String> onInputChanged;
  final ValueChanged<List> onPopupChanged;

  MyAppBar({
    required this.currentIndex,
    required this.valorInput,
    required this.onInputChanged,
    required this.onPopupChanged,
    required this.filtroEValorAppBar,
  });

  @override
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
      backgroundColor: Color.fromARGB(255, 82, 114, 255),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/app_vazado_icon.png',
            width: 40,
          ),
          Expanded(
            child: Stack(
              alignment: Alignment.centerRight,
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
                Positioned(
                  right: 0, 
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          //color: Colors.blue,
                        ),
                        child: IconButton(
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
                          icon: Icon(Icons.filter_list, color: Colors.black, size: 30),
                        ),
                      ),
                      SizedBox(width: 0), // Ajusta o espaçamento entre os botões
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: IconButton(
                          onPressed: () {
                            // Adicione aqui a ação do botão de pesquisa
                          },
                          icon: Icon(Icons.search, color: Colors.white, size: 30),
                        ),
                      ),
                    ],
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
