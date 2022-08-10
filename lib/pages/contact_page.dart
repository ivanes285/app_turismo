// ignore_for_file: avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
            child: Center(
                child: Column(
          children: [
            const SizedBox(
              height: 40.0,
            ),
            Image.asset(
              'assets/logo1.png',
              height: 150,
            ),
            const SizedBox(
              height: 15.0,
            ),
            Text("CONTÁCTANOS",
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 30.0,
                    fontFamily: 'Helvetica',
                    fontWeight: FontWeight.bold,
                    decorationStyle: TextDecorationStyle.wavy)),
            const SizedBox(
              height: 5.0,
            ),
            Text("GAD Municipal de Pedro Moncayo",
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 15.0,
                )),
            const SizedBox(
              height: 15.0,
            ),
            SizedBox(
              width: 280,
              child: Column(
                children: [
                  //YOUTUBE
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      textStyle: const TextStyle(fontSize: 20),
                      primary: Theme.of(context).primaryColorDark,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(size: 30, color: Colors.red, UniconsLine.youtube),
                        SizedBox(width: 5),
                        Text("Míranos en YouTube")
                      ],
                    ),
                    onPressed: () {
                      _launchUrl(
                          "https://www.youtube.com/channel/UCy1IblatwUaRmiDg9Qp9vDw");
                    },
                  ),
                  const SizedBox(height: 5),

                  // FACEBOOK
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      textStyle: const TextStyle(fontSize: 20),
                      primary: Theme.of(context).primaryColorDark,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                            size: 30,
                            color: Colors.blue[700],
                            UniconsLine.facebook),
                        const SizedBox(width: 5),
                        const Text("Síguenos en Facebook")
                      ],
                    ),
                    onPressed: () {
                      _launchUrl("https://www.facebook.com/GADpedromoncayo");
                    },
                  ),
                  const SizedBox(height: 5),
                  // TWITTER

                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      textStyle: const TextStyle(fontSize: 20),
                      primary: Theme.of(context).primaryColorDark,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                            size: 30,
                            color: Colors.blue[400],
                            UniconsLine.twitter),
                        const SizedBox(width: 5),
                        const Text("Síguenos en Twitter")
                      ],
                    ),
                    onPressed: () {
                      _launchUrl("https://twitter.com/GADPedroMoncayo?s=20&t=PQJjxFjvFIu5Fnf2TXPqhw");
                    
                    },
                  ),
                  const SizedBox(height: 5),

                  //INSTAGRAM
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      textStyle: const TextStyle(fontSize: 20),
                      primary: Theme.of(context).primaryColorDark,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                            size: 30,
                            color: Color(0xffE34673),
                            UniconsLine.instagram),
                        SizedBox(width: 5),
                        Text("Síguenos en Instagram")
                      ],
                    ),
                    onPressed: () {
                      _launchUrl("https://www.instagram.com/gadpedromoncayo/");
                    },
                  ),
                  const SizedBox(height: 5),
                  //INSTAGRAM
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      textStyle: const TextStyle(fontSize: 20),
                      primary: Theme.of(context).primaryColorDark,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                            size: 30,
                            color: Color.fromARGB(255, 70, 227, 143),
                            UniconsLine.phone),
                        SizedBox(width: 5),
                        Text("Llámanos")
                      ],
                    ),
                    onPressed: () {
                      _makePhoneCall();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Text("Comentarios o Sugerencias a:",
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 18.0,
                )),
            const SizedBox(
              height: 4.0,
            ),
            InkWell(
                child: const Text('munipm@pedromoncayo.gob.ec',
                    style: TextStyle(
                        color: Color(0xff005CA5),
                        decoration: TextDecoration.underline,
                        fontSize: 16)),
                onTap: () {
                  const toEmail = 'munipm@pedromoncayo.gob.ec';
                  const subject = 'Sugerencia';
                  const message = 'Hola me gustaría hacer una sugerencia ..\n';
                  const url = 'mailto:$toEmail?subject=$subject&body=$message';
                  _launchUrl(url);
                }),
          ],
        ))));
  }
}

Future<void> _makePhoneCall() async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: '(02) 383-6560',
  );

  await launchUrl(launchUri);
}

Future<void> _launchUrl(String url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url,
      mode: LaunchMode.platformDefault,
      webViewConfiguration: const WebViewConfiguration(
        enableJavaScript: true,
      ))) {
    throw 'Could not launch $_url';
  }
}
