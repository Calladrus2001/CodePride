import 'package:http/http.dart' as http;
import 'package:pizza100/Models/NewsModel.dart';
import 'package:pizza100/secrets.dart';

class NewsService {
  Future<News?> getNews() async {
    final String url =
        "https://newsapi.org/v2/everything?q=lgbtq&from=2022-06-01&sortBy=popularity&apiKey=${NEWS_API_KEY}&language=en&pageSize=15";
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return newsFromJson(response.body);
    } else {
      return null;
    }
  }
}
