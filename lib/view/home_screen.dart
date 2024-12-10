import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/model/movies_model.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();

  @override
  void initState() {
    // TODO: implement initState
    homeViewViewModel.fetchMoviesListApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context); 
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
              onTap: (){
                userPreference.logoutUser().then((value){
                  Navigator.pushNamed(context, RoutesName.login);
                });
              },
              child: const Text("Logout")),
              SizedBox(width: 20,)
        ],
      ),
      body: ChangeNotifierProvider<HomeViewViewModel>(
        create: (BuildContext context)=>homeViewViewModel,
        child: Consumer<HomeViewViewModel>(
          builder: (context,value,child){
            switch (value.moviesList.status) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
              
              case Status.ERROR:
                return Center(child: Text(value.moviesList.message.toString()));
              
              case Status.COMPLETED:
                return ListView.builder(
                  itemCount: value.moviesList.data!.movies!.length,
                  itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      leading: Image.network(
                        height: 40,
                        width: 40,
                        fit: BoxFit.contain,
                        value.moviesList.data!.movies![index].posterurl.toString(),
                        errorBuilder: (context, error, stack){
                          return Icon(Icons.error);
                        },
                        ),
                      title: Text(value.moviesList.data!.movies![index].title.toString()),
                      subtitle: Text(value.moviesList.data!.movies![index].year.toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [ 
                          Text(Utils.averageRating(value.moviesList.data!.movies![index].ratings!).toStringAsFixed(1)),
                          Icon(Icons.star,color: Colors.orange,)

                        ],
                      ),
                    ),
                  );
                });
              
              default:
            }
            return Container();
          },
        ),
      ),
    );
  }
}