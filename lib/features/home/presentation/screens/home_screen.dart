import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../config/fireBase_funs.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_strings.dart';
import '../../../profile_settings/data/models/profile_model.dart';
import '../../../profile_settings/presentation/widgets/container_widget.dart';
import '../widgets/bottom_sheet_available_cars_widget.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/show_google_auto_places.dart';
import 'package:geocoding/geocoding.dart' as geoCoding ;

class HomeScreen extends StatefulWidget{
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  LatLng destination ;
  Set<Marker> markers = <Marker>{};
  Set<Polyline> polyLines = {};
  LatLng source ;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  GoogleMapController mapController;
  TextEditingController TextFieldController = TextEditingController();
  TextEditingController TextFieldSourceController = TextEditingController();

  bool showTextFieldForSource = false ;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer (
          child:  DrawerWidget (),
        ),
        body: Stack(
          children: [
            GoogleMap(
              minMaxZoomPreference: MinMaxZoomPreference(5 , 15),
              polylines: polyLines,
              markers: markers,
              mapType: MapType.normal,
              zoomControlsEnabled: false,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                 mapController = controller ;
                 setState((){});
              },
            ) ,
                Container(
                margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 20) ,
                child: Column (
                  children: [
                    FutureBuilder<ProfileModel>(
                        future: FireBaseFuns.getProfileDataFromFireBase(),
                        builder: (context , asynSnapShot){
                          if (asynSnapShot.connectionState == ConnectionState.waiting){
                            return Center(child: CircularProgressIndicator(),);
                          }else if (asynSnapShot.hasError){
                            return Column(
                              children: [
                                Icon(Icons.wifi_off_sharp , color: Colors.black,),
                                SizedBox(height: 5,),
                                Text("Somthing went wrong")
                              ],
                            );
                          } else {
                            /// data
                            var data = asynSnapShot.data ;
                            return Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle ,
                                  ),
                                  child: Image (image: NetworkImage(data.image ?? ""),
                                    fit: BoxFit.fill,width: double.infinity, height: double.infinity,),
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                        text: TextSpan(
                                            children: [
                                              TextSpan(
                                                  text: "Good morninig " ,
                                                  style: TextStyle(color: Colors.black , fontSize: 15)
                                              ),
                                              TextSpan(
                                                  text: data.name ?? "" ,
                                                  style: TextStyle(color: Colors.green[600] , fontSize: 15 , fontWeight: FontWeight.bold)
                                              ),
                                            ]
                                        )),
                                    Text("Where are you going?" , style: TextStyle(color: Colors.black , fontSize: 20 ,
                                        fontWeight: FontWeight.bold),)
                                  ],
                                )
                              ],
                            );
                          }
                        }),
                    SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                    Container(
                      decoration: BoxDecoration (
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 4,
                            blurRadius: 4 ,
                            color: Colors.black.withOpacity(0.04)
                          )
                        ]
                      ),
                      child: TextField(
                        controller: TextFieldController,
                        readOnly: true,
                        onTap: ()async{
                         String selectedPlace = await showGoogleAutoPlaces(context , mapController);
                         List<geoCoding.Location> locations = await geoCoding.locationFromAddress(selectedPlace);
                         destination = LatLng(locations.first.latitude, locations.first.longitude);
                         markers.add(Marker(markerId: MarkerId(selectedPlace) ,
                             infoWindow: InfoWindow(title: "destination : $selectedPlace") , position: destination ,));
                         mapController.animateCamera(
                           CameraUpdate.newCameraPosition(CameraPosition(target: destination , zoom: 14))
                         );
                         setState((){
                           TextFieldController.text = selectedPlace ;
                           showTextFieldForSource = true ;
                           print(selectedPlace);
                         });
                        },
                        decoration: InputDecoration (
                          suffixIcon: Icon(Icons.search),
                          border: InputBorder.none ,
                          filled: true ,
                          fillColor: Colors.white ,
                          hintText: "Search for a destination" ,
                          hintStyle: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold)
                        ),
                      ),
                    ) ,
                    SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                    showTextFieldForSource && TextFieldController.text != null ?  Container(
                      decoration: BoxDecoration (
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 4,
                                blurRadius: 4 ,
                                color: Colors.black.withOpacity(0.04)
                            )
                          ]
                      ),
                      child: TextField(
                        controller: TextFieldSourceController,
                        readOnly: true,
                        onTap: ()async{
                            showBottomSheetFun ();
                        },
                        decoration: InputDecoration (
                            suffixIcon: Icon(Icons.search),
                            border: InputBorder.none ,
                            filled: true ,
                            fillColor: Colors.white ,
                            hintText: "From:" ,
                            hintStyle: TextStyle(fontSize: 16 , fontWeight: FontWeight.bold)
                        ),
                      ),
                    ) : Container(),
                  ],
                ),
              ),
                  Padding(
                  padding: const EdgeInsets.only(right: 15 , bottom: 30),
                       child: Align(
                      alignment: Alignment.bottomRight,
                       child: CircleAvatar(
                      backgroundColor: AppColors.primaryColor,
                         radius: 25,
                         child: Icon(Icons.my_location , color: Colors.white,),
                         ),
                         ),
                           ),
                       Padding(
                      padding: const EdgeInsets.only(left: 15 , bottom: 30),
                      child: Align(
                     alignment: Alignment.bottomLeft,
                     child: CircleAvatar(
                     child: Icon(Icons.notification_important , color: Colors.white,),
                        radius: 25,
                          backgroundColor: Colors.grey.shade400,
                           ),
                         ),
                             ) ,
                           Align(
                           alignment: Alignment.bottomCenter,
                          child: Container(
                        width: MediaQuery.of(context).size.width*0.6,
                          height: MediaQuery.of(context).size.height*0.04,
                       decoration: BoxDecoration (
                         color: Colors.white,
                       borderRadius: BorderRadius.only(topLeft: Radius.circular(20) ,topRight: Radius.circular(20) ,)
                      ),
                       child: Center (
                        child: Container(
                        width: MediaQuery.of(context).size.width*0.4,
                         height: MediaQuery.of(context).size.height*0.01,
                                decoration: BoxDecoration (
                            color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(20)
                            ,)
                            ),

                             ),
                            ),
                               ),
                              ]
                            )
        ),
    );

  }

  void showBottomSheetFun() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
          child: Column (
            children: [
              Row(
                children: [
                  Text("Select your location" , style: TextStyle(color: Colors.black , fontSize: 20 , fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.04,),
              Text(AppStrings.home , style: TextStyle(color: Colors.black , fontSize: 20 , fontWeight: FontWeight.bold),),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              FutureBuilder<ProfileModel>(
                  future: FireBaseFuns.getProfileDataFromFireBase(),
                  builder: (context , asyncSnapShot){
                    if (asyncSnapShot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator(),);
                    }else if (asyncSnapShot.hasError){
                      return Text("Something get error");
                    }else {
                      /// data
                      var data = asyncSnapShot.data ;
                      return InkWell(
                        onTap: ()async{
                          Navigator.pop(context);
                          String homePlace =  data.homeAddress;
                          TextFieldSourceController.text = homePlace ;
                          List<geoCoding.Location> locations = await geoCoding.locationFromAddress(homePlace);
                          source = LatLng(locations.first.latitude, locations.first.longitude);
                          markers.add(Marker(markerId: MarkerId(homePlace) , infoWindow: InfoWindow(
                              title: "source : $homePlace"
                          ) , position: source
                          ));
                          if (markers.length > 2){
                            markers.remove(markers.last);
                          }
                          drawPolyLines(homePlace);
                          mapController.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(target:  source , zoom: 14))
                          );
                          bottomSheetCars();
                          setState(() {

                          });
                        },
                        child: Container(
                            width: double.infinity,
                            child: containerWidget(context , data.homeAddress)),
                      );
                    }
                  }),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Text(AppStrings.business , style: TextStyle(color: Colors.black , fontSize: 20 , fontWeight: FontWeight.bold),),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              FutureBuilder<ProfileModel>(
                  future: FireBaseFuns.getProfileDataFromFireBase(),
                  builder: (context , asyncSnapShot){
                    if (asyncSnapShot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator(),);
                    }else if (asyncSnapShot.hasError){
                      return Text("Something get error");
                    }else {
                      /// data
                      var data = asyncSnapShot.data ;
                      return InkWell(
                        onTap: ()async{
                          Navigator.pop(context);
                          String businessAddress =  data.businessAddress;
                          TextFieldSourceController.text = businessAddress ;
                          List<geoCoding.Location> locations = await geoCoding.locationFromAddress(businessAddress);
                          source = LatLng(locations.first.latitude, locations.first.longitude);
                          markers.add(Marker(markerId: MarkerId(businessAddress) , infoWindow: InfoWindow(
                              title: "source : $businessAddress"
                          ) , position: source
                          ));
                          if (markers.length > 2){
                            markers.remove(markers.last);
                          }
                          drawPolyLines(businessAddress);
                          mapController.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(target:  source , zoom: 14))
                          );
                          bottomSheetCars();
                          setState(() {

                          });
                        },
                        child: Container(
                            width: double.infinity,
                            child: containerWidget(context , data.homeAddress)),
                      );
                    }
                  }),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              Text(AppStrings.custom_place , style: TextStyle(color: Colors.black , fontSize: 20 , fontWeight: FontWeight.bold),),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              InkWell(
                onTap: ()async{
                  Navigator.pop(context);
                  String customPlace =  await showGoogleAutoPlaces (context , mapController);
                  TextFieldSourceController.text = customPlace ;
                  List<geoCoding.Location> locations =await  geoCoding.locationFromAddress(customPlace);
                  source = LatLng(locations.first.latitude, locations.first.longitude);
                  markers.add(Marker(markerId: MarkerId(customPlace) , infoWindow: InfoWindow(
                    title: "source : $customPlace" ,
                  ) , position: source ,
                  ));
                  if (markers.length > 2){
                    markers.remove(markers.last);
                  }
                  drawPolyLines(customPlace);
                  mapController .animateCamera(
                      CameraUpdate.newCameraPosition(CameraPosition(target: source , zoom: 14))
                  );
                  bottomSheetCars();
                  setState(() {

                  });
                },
                child: Container(
                    width: double.infinity,
                    child: containerWidget(context , AppStrings.search_for_custom_place)),
              ),
            ],
          ),
        ));
  }

  void bottomSheetCars (){
    showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheetAvailableCarsWidget());
  }

  void drawPolyLines (String polyLineId){
    polyLines.clear();
    polyLines.add(Polyline(
        polylineId: PolylineId(polyLineId) ,
        visible: true,
        points: [source,destination],
        color: AppColors.primaryColor ,
        width: 3
    ));
  }



}
/// AIzaSyA9wNAXLazX_MoD_JB44RxZw-RwwWSE8DY