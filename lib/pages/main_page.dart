import 'package:app_turismo/pages/contact_page.dart';
import 'package:app_turismo/pages/home_page.dart';
import 'package:app_turismo/pages/setting_page.dart';
import 'package:app_turismo/theme/style_global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }
}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return BottomNavigationBar(
    
      backgroundColor: Themas.kBackgroundColorButton,
      selectedItemColor: Themas.kWhiteColor,
      iconSize: 35,
      selectedFontSize: 13,
      unselectedItemColor: Themas.kWhiteColord,
      unselectedFontSize: 10,
      currentIndex: navegacionModel.paginaActual,
      onTap: (i) => navegacionModel.paginaActual = i,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.smart_screen), label: 'Contacto'),
        BottomNavigationBarItem(icon: Icon(Icons.help), label: 'Settings')
      ],
    );
  }
}


class _Paginas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);
    return PageView(
      controller: navegacionModel._pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [HomePage(), ContactPage(), SettingPage()],
    );
  }
}


class _NavegacionModel extends ChangeNotifier {
  int _paginaActual = 0;
  final PageController _pageController = PageController();
  int get paginaActual => _paginaActual;
  set paginaActual(int valor) {
    _paginaActual = valor;
    _pageController.animateToPage(valor,
        duration: const Duration(microseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
