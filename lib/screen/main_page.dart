import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_search/app_const.dart';
import 'package:movie_search/model/movie_model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String title1="Spider Man: Lost Cause";
  String raitingText="111";
  String image="https://m.media-amazon.com/images/M/MV5BYmZkYWRlNWQtOGY0Zi00MWZkLWJiZTktNjRjMDY4MTU2YzAyXkEyXkFqcGdeQXVyMzYzNzc1NjY@._V1_SX300.jpg";
  double raiting=0;
  final TextEditingController controller=TextEditingController();
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
         backgroundColor: Colors.black,

        
        title: TextField(
          
          onChanged: (value) => getData(value),
          controller: controller,
          decoration:  InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10), 

            
            hintText: "Enter the movie name",
            border: OutlineInputBorder(
              
              borderRadius: BorderRadius.circular(25),
            ),
            fillColor: const Color(0xff808080),
            filled: true,
            
          )
        ),
        actions: [
        
        IconButton(onPressed: (){
          getData(controller.text);
        }, icon: const Icon(Icons.search),)

      ],

      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
               Text(title1,style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              const SizedBox(height: 20,),
            Image.network(image,errorBuilder: (context,error,stackTrace)=>Text(error.toString()),),
              const SizedBox(height: 20,),
              Text(raitingText,style: const TextStyle(fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              const SizedBox(height: 20,),
        
            RatingBar.builder(
           initialRating: raiting,
           minRating: 0,
           direction: Axis.horizontal,
           allowHalfRating: true,
           itemCount: 10,
           
           itemBuilder: (context, _) => const Icon(
             Icons.star,
             color: Colors.amber,
           ),
           onRatingUpdate: (rating) {
             print(rating);
           },
        )
          ],),
        ),
      ),
    );
  }
  
  Future<void>getData(String title)async{
  final Dio dio=Dio();
  try{
    final Response response=await dio.get("http://www.omdbapi.com/",
  queryParameters: {
    "apikey":AppConsts.apikey,
    "t":title
  });
  
  final result= MovieModel.fromJson(response.data);
  image =result.poster??"";
  title1=result.title??"";
  raitingText=result.ratings?[0].value??"";
  raiting=double.tryParse(result.imdbRating??"")??0;
  }catch(e){
    title="error";
    raiting=0;
    raitingText=e.toString();
    image="https://uploads.sitepoint.com/wp-content/uploads/2015/12/1450973046wordpress-errors.png";
  }
  
  setState(() {
    
  });
}
}


