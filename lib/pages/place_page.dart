import 'package:app_turismo/models/lugares.dart';
import 'package:app_turismo/pages/placedetail_page.dart';
import 'package:app_turismo/theme/style_global.dart';
import 'package:app_turismo/utils/skeletos.dart';
import 'package:flutter/material.dart';

class Places {
  static Widget places(
      bool loadingPlaces, List<LugaresModel> listLugares, context) {
    PageController pageControllerPlaces =
        PageController(viewportFraction: 0.45);
    if (loadingPlaces) return Skeletos.sckeletoPlace();
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: 250,
      child: listLugares.isNotEmpty
          ? PageView.builder(
              controller: pageControllerPlaces,
              physics: const BouncingScrollPhysics(),
              padEnds: false,
              itemCount: listLugares.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return Container(
                  margin: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => {
                              FocusScope.of(context).unfocus(),
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PlaceDetail(lugar: listLugares[index])),
                              )
                            },
                            child: FadeInImage(
                              height: 150,
                              width: double.infinity,
                              placeholder:
                                  const AssetImage('assets/no-image.png'),
                              image:
                                  NetworkImage(listLugares[index].images![0]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          color: const Color(0xff21564C),
                          height: 70.0,
                          width: double.infinity,
                          child: Center(
                              child: Text(
                            listLugares[index].title!.toUpperCase(),
                            style: const TextStyle(
                                 color: Colors.white,
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                        ),
                      ],
                    ),
                  ),
                );
              })
          : //

          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Themas.kBackgroundColorButton,
              ),
              padding: const EdgeInsets.all(30),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upps..',
                    style: Themas.whiteTextStyle.copyWith(
                      fontSize: 18,
                      color: const Color(0xffC70039),
                      fontWeight: Themas.semiBold,
                    ),
                  ),
                  const SizedBox(height: 45),
                  const Center(
                      child: Text('😨 No se encontraron registros ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          )))
                ],
              ),
            ),
    );
  }
}
