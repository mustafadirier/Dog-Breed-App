import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_breed_app/bloc/dog_bloc.dart';
import 'package:dog_breed_app/event/dog_event.dart';
import 'package:dog_breed_app/model/breed_model.dart';
import 'package:dog_breed_app/repository/dog_repository.dart';
import 'package:dog_breed_app/state/dog_state.dart';
import 'package:dog_breed_app/ui/shared/uicolor.dart';
import 'package:dog_breed_app/ui/shared/uifont.dart';
import 'package:dog_breed_app/ui/shared/uipath.dart';
import 'package:dog_breed_app/ui/widgets/widget_appbar.dart';
import 'package:dog_breed_app/ui/widgets/widget_no_dog_breed.dart';
import 'package:dog_breed_app/ui/widgets/widget_settings_bottom_sheet.dart';
import 'package:dog_breed_app/ui/widgets/widget_text.dart';
import 'package:dog_breed_app/ui/widgets/widget_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ViewHome extends StatelessWidget {
  const ViewHome({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: body(context, queryData),
      bottomSheet: buildCustomBottomBar(context, queryData),
      appBar: appBar(),
    );
  }

  Widget body(BuildContext context, queryData) {
    final dogBloc = BlocProvider.of<DogBloc>(context);
    return Stack(
      children: [
        BlocBuilder<DogBloc, DogState>(
          builder: (context, state) {
            var breeds = (state as DogStateUpdated).breeds;
            return Container(
              color: UIColor.white,
                padding: EdgeInsets.only(left: 16, right: 16),
                width: queryData.size.width,
                height: queryData.size.height,
                child: breeds.length > 0
                    ? AnimatedSwitcher(
                        duration: Duration(milliseconds: 500),
                        child: GridView.builder(
                          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                          padding: EdgeInsets.only(bottom: 96),
                          itemCount: breeds.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () =>
                                  breedPreviewPopUp(context, breeds[index]),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  cachedImage(breeds[index].image ?? "",
                                      BorderRadius.circular(16)),
                                  ClipRRect(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          gradient: UIGradient.cardGradient,
                                          border: Border.all(
                                              color: UIColor.systemGray6)),
                                    ),
                                  ),
                                  Positioned(
                                    left: 8,
                                    bottom: 8,
                                    child: TextBasic(
                                      text: breeds[index].name ?? "",
                                      fontWeight: FontWeight.w500,
                                      color: UIColor.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : noDogBreedPage());
          },
        ),
        Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: searchBox(context, dogBloc, queryData))
      ],
    );
  }

  Widget searchBox(context, dogBloc, MediaQueryData queryData) {
    TextEditingController _controller = TextEditingController();

    FocusNode _focusNode = FocusNode();
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              height: 64,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: UIColor.black.withOpacity(.28),
                      blurRadius: 16,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: BasicTextField(
                  
                  // keyboardType: TextInputType.none,
                  hint: "Search",
                  focusNode: _focusNode,
                requestFocus: _focusNode,
                  controller: _controller,
                  obscureText: false,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                        color: UIColor.systemGray5,
                      )),
                  onTap: () async{
                    searchBoxBottomSheet(
                    context,
                    dogBloc,
                    _controller,
                    _focusNode,
                  );}
                ),
              ),
            )),
        SizedBox(height: 16 + 98),
      ],
    );
  }

  void searchBoxBottomSheet(context, dogBloc, _controller, _focusNode) async {
    showModalBottomSheet(
      
      backgroundColor: UIColor.white,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
            initialChildSize: 0.5,
             
            minChildSize: 0.2,
            maxChildSize: 1,
            expand: false,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                controller: scrollController,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 32,
                        height: 4,
                        decoration: ShapeDecoration(
                          color: UIColor.systemGray5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      BasicTextField(     
                        hint: "Search",
                        enabled: true,
                        obscureText: false,
                        focusNode: _focusNode,
                        controller: _controller,
                        onChanged: (value) {
                          dogBloc.add(SearchBreedEvent(query: value));
                        },
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }

  Widget buildCustomBottomBar(context, MediaQueryData queryData) {
    return Stack(
      children: [
        Container(
          child: SvgPicture.asset(
            UIPath.tab,
            width: queryData.size.width,
          ),
        ),
        Positioned.fill(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              bottomBarTabItem(
                  assetName: UIPath.homeIcon,
                  tabText: "Home",
                  color: UIColor.primaryColor),
              Container(
                  height: 24,
                  width: 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: UIColor.systemGray4,
                  )),
              GestureDetector(
                onTap: () {
                  expandableSettingsBottomSheet(context);
                },
                child: bottomBarTabItem(
                    assetName: UIPath.settingsIcon,
                    tabText: "Settings",
                    color: UIColor.black),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget bottomBarTabItem(
      {required String assetName,
      required String tabText,
      required Color color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          assetName,
          width: 32,
        ),
        SizedBox(height: 4),
        TextBasic(
          text: tabText,
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.bold,
        )
      ],
    );
  }

  breedPreviewPopUp(context, BreedModel breed) {
    return showDialog<String>(
      anchorPoint: Offset(0, 11),
      context: context,
      builder: (BuildContext context) => Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          child: Container(
            height: 630,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                          height: 315,
                          width: double.infinity,
                          child: cachedImage(
                            breed.image.toString(),
                            BorderRadius.only(
                                topLeft: Radius.circular(12.0),
                                topRight: Radius.circular(12.0)),
                          )),
                      Positioned(
                        top: 12,
                        right: 0,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: CircleBorder()),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(UIPath.closeIcon,
                              width: 16, fit: BoxFit.contain),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 315,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 16),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8.0,
                              left: 32,
                              right: 32,
                            ),
                            child: TextBasic(
                              text: 'Breed',
                              color: UIColor.primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Divider(
                            endIndent: 32,
                            indent: 32,
                            color: UIColor.systemGray6,
                            thickness: 2,
                            height: 0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 11.0,
                              bottom: 8,
                              left: 32,
                              right: 32,
                            ),
                            child: TextBasic(
                              text: breed.name ?? "",
                              fontSize: 16,
                            ),
                          ),
                          breed.subBreeds?.length != 0
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                        left: 32,
                                        right: 32,
                                      ),
                                      child: TextBasic(
                                        text: 'Sub Breed',
                                        color: UIColor.primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Divider(
                                      color: UIColor.systemGray6,
                                      thickness: 2,
                                      height: 0,
                                      endIndent: 32,
                                      indent: 32,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8,
                                        bottom: 4,
                                        left: 32,
                                        right: 32,
                                      ),
                                      child: SizedBox(
                                        height: 115,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: breed.subBreeds?.length,
                                          itemBuilder: (context, index) =>
                                              TextBasic(
                                            textAlign: TextAlign.center,
                                            text: breed.subBreeds?[index],
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                            ),
                            child: ElevatedButton(
                              style: TextButton.styleFrom(
                                  minimumSize: const Size.fromHeight(56),
                                  backgroundColor: UIColor.buttonColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)))),
                              onPressed: () {
                                // Navigator.of(context).pop();
                                generateImage(context, breed);
                              },
                              child: TextBasic(
                                text: 'Generate',
                                fontFamily: UIFont.galano,
                                fontSize: 18,
                                color: UIColor.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

 generateImage(context, BreedModel breed) async {
  String randomImage = await DogRepository().getRandomImageByBreed(breed.name);
  return showDialog<String>(
      barrierDismissible: false,
      anchorPoint: Offset(0, 11),
      context: context,
      builder: (BuildContext context) => Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  cachedImage(
                    randomImage,
                    BorderRadius.circular(12),
                  ),
                  const SizedBox(height: 12),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: UIColor.white,
                              borderRadius: BorderRadius.circular(2)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              UIPath.closeIcon,
                            ),
                          ))),
                ],
              ),
            ),
          ));
}

Widget cachedImage(String imageUrl, BorderRadiusGeometry borderRadius) {
  return ClipRRect(
    borderRadius: borderRadius,
    child: CachedNetworkImage(
      imageUrl: imageUrl,
      width: 256,
      height: 256,
      fit: BoxFit.cover,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Center(
        child: SvgPicture.asset(
          UIPath.logo,
          width: 256,
        ),
      ),
    ),
  );
}
