import 'package:http/http.dart' as http;
import 'package:gbk2utf8/gbk2utf8.dart';
class tools{
  final url=["http://www.gaokao.com/baokao/yxdq/gkxxs/index.shtml",
  "http://www.gaokao.com/baokao/yxdq/gkxxs/index_2.shtml",
  "http://www.gaokao.com/baokao/yxdq/gkxxs/index_3.shtml",
  "http://www.gaokao.com/baokao/yxdq/gkxxs/index_4.shtml",
  "http://www.gaokao.com/baokao/yxdq/gkxxs/index_5.shtml"];
  List<OneNew> newsList=new List();
  findnewsList(int page) async{
    try {
      http.Response response = await http.get(url[page-1]);
      //此处的data为新闻列表的完整html
      String data = gbk.decode(response.bodyBytes);
      //直接用字符串切割获得新闻的List
      List<String> tempList=data.split('<h2 class="h2_tit">');
      tempList.removeLast();
      tempList.removeAt(0);
      String onestr="";
        for(int i=0;i<tempList.length;i++){
          onestr=tempList.elementAt(i);
          //print(onestr);
          var one=new OneNew("url error", "title error", "date error");
          one.url=onestr.split('<a href="').elementAt(1).split('" target="_blank"').elementAt(0);
          one.title=onestr.split('target="_blank" title="').elementAt(1).split('">').elementAt(0);
          one.date=onestr.split('<span>').elementAt(1).split('</span>').elementAt(0);
          newsList.add(one);
        }

      //print(_text);
    } catch (e) {
      //网络出问题了！
    }
  }

}
class OneNew{
  String url;
  String title;
  String date;
  OneNew(String u,String t,String d){
    url=u;
    title=t;
    date=d;
  }
  @override
  String toString() {
    // TODO: implement toString
    return "url:"+url+"\ntitle:"+title+"\ndate:"+date+"\n";
  }
}
/*main(List<String> arguments) {
  tools().getnewsList(2);
}*/