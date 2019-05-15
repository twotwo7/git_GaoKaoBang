import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui';
//import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:gaokaobang/tools/tools.dart';
import 'package:http/http.dart' as http;
import 'package:gbk2utf8/gbk2utf8.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:gaokaobang/tools/SqlHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
/*SqlHelper sqlhelper=new SqlHelper();
String path="";
String tablename='News';
void initsql() async{
  var databasesPath = await getDatabasesPath();
  path = join(databasesPath, 'history.db');
  String SqlCreate='CREATE TABLE IF NOT EXISTS News (id INTEGER PRIMARY KEY, url TEXT, title TEXT, date TEXT)';
  await sqlhelper.create(path, SqlCreate);
}*/
class getHomeList extends StatefulWidget {
  @override
  createState() => new getHomeListState();
}
class getHomeListState extends State<getHomeList> {
  List<OneNew> newsList = new List();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  var page=1;
  bool isReadyDownLoad=true;
  @override
  void initState() {
    var url="http://www.gaokao.com/baokao/yxdq/gkxxs/index.shtml";
    page++;
    findnewsList(url);
  }
  @override
  Widget build(BuildContext context) {
    //init();
    //initsql();
    return /*Text(newsList.elementAt(0).toString());*/
    new Scaffold(
      appBar: new AppBar(
        title: new Text('高考帮'),
        backgroundColor: Color.fromRGBO(0x57, 0xC3, 0xC2, 100),
        elevation: 0,
      ),
      body: _buildSuggestions() ,
    );
  }
  Widget _buildSuggestions() {
    if (newsList.isEmpty) {
      return new Center(child: new CircularProgressIndicator());
    } else {
      return new ListView.builder(
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, i) {
          if (i == 0) return new Container(child:new SwiperPage(),height: 200,);//new CountDownPage();
          //分割线
          if (i.isOdd) return new Divider();

          final index = i ~/ 2;
          if (index >= newsList.length && page < 100&&newsList.length>=10&&isReadyDownLoad) {
            //滑倒底了
            print(newsList.length);
            isReadyDownLoad=false;
            var url;
            if(page==1){url="http://www.gaokao.com/baokao/yxdq/gkxxs/index.shtml";}
            else{ url="http://www.gaokao.com/baokao/yxdq/gkxxs/index_"+page.toString()+".shtml";}
            print("page:"+page.toString());
            page++;
            findnewsList(url);
          }
          try{
            return _buildRow(newsList.elementAt(index-1));
          }catch(e){
            return _buildRow(new OneNew("nothing", "XXXXXXXXXXXXXXXXX", " "));
          }
        },
      );
    }

  }
  Widget _buildRow(OneNew news) {
    return new ListTile(
      title: new Text(
        news.title,
        style: _biggerFont,
      ),
      trailing: new Text(news.date),
      onTap: () {
        setState(
              () {
            clicknews(news);
          },
        );
      },
    );
  }
  void clicknews(OneNew onenew) {
    /*var valuesmap = <String, dynamic>{
      'url': onenew.url,
      'title': onenew.title,
      'date':onenew.date,
    };
    sqlhelper.insert(path,tablename, valuesmap);*/
    print(onenew.url);
    DateTime now = new DateTime.now();
    String date = now.toString().substring(0,10);
    initsql(onenew.url, onenew.title,date);
    Navigator.push(
        this.context,
        new MaterialPageRoute(
            builder: (context) => new NewsWebPage(onenew.url, onenew.title))
    );
  }
  void initsql(String url,String title,String date) async{
    SqlHelper sqlhelper=new SqlHelper();
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'history.db');
    String SqlCreate='CREATE TABLE IF NOT EXISTS News (id INTEGER PRIMARY KEY, url TEXT, title TEXT, date TEXT)';
    await sqlhelper.open(path, SqlCreate);
    String tablename='News';
    var valuesmap = <String, dynamic>{
      'url': url,
      'title': title,
      'date':date,
    };
    //String Sqlfind = 'select * from News where ';
    int id=await sqlhelper.insert(path,tablename,valuesmap);
    sqlhelper.close();
    print(id);
  }
  findnewsList(String url) async {
    try {
      http.Response response = await http.get(url);
      //此处的data为新闻列表的完整html
      String data = gbk.decode(response.bodyBytes);
      print(data);
      //直接用字符串切割获得新闻的List
      List<String> tempList = data.split('<h2 class="h2_tit">');
      tempList.removeLast();
      tempList.removeAt(0);
      String onestr = "";
      setState(() {
        for (int i = 0; i < tempList.length; i++) {
          onestr = tempList.elementAt(i);
          //print(onestr);
          //url="http://112.74.39.182:5001/clickNew?url="+url;
          var one = new OneNew("url error", "title error", "date error");
          one.url = "http://112.74.39.182:5001/clickNew?url=http://m"+onestr.split('<a href="http://www').elementAt(1)
              .split('" target="_blank"')
              .elementAt(0);
          print(one.url+"12345");
          one.title = onestr.split('target="_blank" title="').elementAt(1)
              .split('">')
              .elementAt(0);
          one.date =
              onestr.split('<span>').elementAt(1).split('</span>').elementAt(0);
          newsList.add(one);
          //print(one.toString());
        }
      });
      //print(_text);
    } catch (e) {
      //网络出问题了！
      print("ERROR：获取新闻列表"+e.toString());
    }
    isReadyDownLoad=true;
  }
}
class NewsWebPage extends StatefulWidget{
  String  news_url;
  String title;

  NewsWebPage(this.news_url,this.title);

  @override
  State<StatefulWidget> createState()=>new NewsWebPageState(news_url,title);

}
class NewsWebPageState extends State<NewsWebPage>{
  String  news_url;
  String title;
  // 标记是否是加载中
  bool loading = true;
  // 标记当前页面是否是我们自定义的回调页面
  bool isLoadingCallbackPage = false;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  // URL变化监听器
  StreamSubscription<String> onUrlChanged;
  // WebView加载状态变化监听器
  StreamSubscription<WebViewStateChanged> onStateChanged;
  // 插件提供的对象，该对象用于WebView的各种操作
  FlutterWebviewPlugin flutterWebViewPlugin = new FlutterWebviewPlugin();

  NewsWebPageState(this.news_url, this.title);

  @override
  void initState() {
    onStateChanged = flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state){
      // state.type是一个枚举类型，取值有：WebViewState.shouldStart, WebViewState.startLoad, WebViewState.finishLoad
      switch (state.type) {
        case WebViewState.shouldStart:
        // 准备加载
          setState(() {
            loading = true;
          });
          break;
        case WebViewState.startLoad:
        // 开始加载
          break;
        case WebViewState.finishLoad:
        // 加载完成
          setState(() {
            loading = false;
          });
          if (isLoadingCallbackPage) {
            // 当前是回调页面，则调用js方法获取数据
            parseResult();
          }
          break;
      }
    });
  }
  // 解析WebView中的数据
  void parseResult() {
//    flutterWebViewPlugin.evalJavascript("get();").then((result) {
//      // result json字符串，包含token信息
//
//    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> titleContent = [];
    titleContent.add(new Text(
//      title,
      "新闻详情",
      style: new TextStyle(color: Colors.white),
    ));
    if (loading) {
      // 如果还在加载中，就在标题栏上显示一个圆形进度条
      titleContent.add(new CupertinoActivityIndicator());
    }
    titleContent.add(new Container(width: 50.0));
    // WebviewScaffold是插件提供的组件，用于在页面上显示一个WebView并加载URL
    return new WebviewScaffold(
      key: scaffoldKey,
      url:news_url, // 登录的URL
      appBar: new AppBar(
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: titleContent,
        ),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      /*
      * divset = document.getElementsByClassName("addtop");
 for (var i = 0; i<divset.length;i++) {
   divset[i].style.display="none";
 };*/
      withZoom: false,  // 允许网页缩放
      withLocalStorage: false, // 允许LocalStorage
      withJavascript: false, // 允许执行js代码
    );
  }

  @override
  void dispose() {
    // 回收相关资源
    // Every listener should be canceled, the same should be done with this stream.
    onUrlChanged.cancel();
    onStateChanged.cancel();
    flutterWebViewPlugin.dispose();
    super.dispose();
  }
}
//高考倒计时
class CountDownPage extends StatefulWidget{
  @override
  createState() => new CountDownPageState();
}
class CountDownPageState extends State<CountDownPage>{
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context){
    int nowTimestamp = new DateTime.now().millisecondsSinceEpoch;
    int gaokaoTimestamp=new DateTime(new DateTime.now().year,6,7).millisecondsSinceEpoch;
    int conutdownTimestamp=gaokaoTimestamp-nowTimestamp;
    if(conutdownTimestamp<0){
      gaokaoTimestamp=new DateTime(new DateTime.now().year+1,6,7).millisecondsSinceEpoch;
      conutdownTimestamp=gaokaoTimestamp-nowTimestamp;
    }
    //DateTime conutdownDayTime=new DateTime.fromMillisecondsSinceEpoch(conutdownTimestamp);
    int days=conutdownTimestamp~/(3600*24*1000);
    return new Container(
      color: Color.fromRGBO(0x57, 0xC3, 0xC2, 100),
      height: MediaQuery.of(context).size.height*(0.8/5.0),
      width: MediaQuery.of(context).size.width,
      child: new Container(
        child: Column(
          children: <Widget>[
            //new Container(height: MediaQuery.of(context).size.height*(1.0/18.0),),
            new Text(days.toString(), style: TextStyle(fontSize: MediaQuery.of(context).size.height*(0.5/5.0),color: Colors.white,fontWeight: FontWeight.w900),),
            new Text("高考倒计时", style: TextStyle(fontSize: MediaQuery.of(context).size.height*(0.12/5.0), color: Colors.white,fontWeight: FontWeight.w700)
            ),
          ],
        ) ,
      )

    );
  }
}


class SwiperPage extends StatefulWidget {
  @override
  SwiperPageState createState() {
    return SwiperPageState();
  }
}

class SwiperPageState extends State<SwiperPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: 200.0,
          child: Swiper(
            itemBuilder: _swiperBuilder,
            itemCount: 3,
            pagination: new SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                  color: Colors.black54,
                  activeColor: Colors.white,
                )),
            control: new SwiperControl(),
            scrollDirection: Axis.horizontal,
            autoplay: true,
            onTap: (index) => print('点击了第$index个'),
          )),
    );
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return (Image.network(
      "http://via.placeholder.com/350x150",
      fit: BoxFit.fill,
    ));
  }
}
