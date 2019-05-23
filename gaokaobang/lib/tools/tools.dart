import 'dart:convert';
import 'dart:io';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:path/path.dart';

/*void main(List<String> arguments) {
  BuildContext context;
  Major major=new Major(context);
  major.init();
  //major.test();
  //print(major.compareSCHOOLNAME("交通大学","北京交通大学"));
  //print(major.compareSCORE(50, 60, 9));
  print(major.search("000000","","",0,0));
}*/
class Major{
  List<String> major_str=new List();
  Map<String,Object> map=new Map();
  List<Map> major_map_list=new List();
  BuildContext context;
  String data;
  Future<String> loadAsset() async {
    return await rootBundle.loadString('data/2017allData_haveid.json');
  }
  init() async{
    data=await loadAsset();
    major_str=data.split("\$");
    print("*************************");
    print(major_str[0]);
    for(int i=0;i<major_str.length;i++){
      map=json.decode(major_str[i]);
      major_map_list.add(map);
    }
  }
  Major() {
    //String data="";
    //String data=new File('data/2017allData_haveid.json').readAsStringSync();
    //String data=DefaultAssetBundle.of(context).loadString("data/2017allData_haveid.json").toString();
    //String data = snapshot.data.toString();
    /*var asset=loadAsset().then((val){
      data=val.toString();
    });*/
  }
  test(){
    print(major_map_list[10]);
  }
  //输入：科目id(6位)，学校名，专业名，分数,分数范围
  List<Map> search(String yaoqiu_id,String schoolname,String specialtyname,int score,int range){
    return major_map_list;
    List<Map> result=new List();
    for(int i=0;i<major_map_list.length;i++){
      if(compareSCORE(score, major_map_list[i]['var'], range)&&compareSPECIALTYNAME(specialtyname,major_map_list[i]['specialtyname'])&&compareYAOQIU(yaoqiu_id, major_map_list[i]['yaoqiu_id'])&&compareSCHOOLNAME(schoolname,  major_map_list[i]['schoolname'])){
        result.add(major_map_list[i]);
      }
    }//
    return result;
  }
  List<Map> searchFromYaoQiuid(String yaoqiu_id){
    List<Map> result=new List();
    for(int i=0;i<major_map_list.length;i++){
      if(compareYAOQIU(yaoqiu_id, major_map_list[i]['yaoqiu_id'])){
        result.add(major_map_list[i]);
      }
    }//
    return result;
  }
  List<Map> searchFromSchoolName(String yaoqiu_id,String schoolname){
    List<Map> result=new List();
    for(int i=0;i<major_map_list.length;i++){
      if(compareSCHOOLNAME(schoolname,major_map_list[i]['schoolname'])&&compareYAOQIU(yaoqiu_id, major_map_list[i]['yaoqiu_id'])){
        result.add(major_map_list[i]);
      }
    }//
    return result;
  }
  //将字符串转化成二进制数代表的int
  int str2byte(String str){
    int ans=0;
    int k=1;
    for(int i=str.length-1;i>-1;i--,k*=2){
      if(str[i]=="1"){
        ans=ans+k;
      }
    }
    return ans;
  }
  //输入：用户的yaoqiu_id，数据中的id
  bool compareYAOQIU(String user,String data){
    if(user==""||user=="000000")return true;

    bool result=false;
    int userint=str2byte(user);
    int dataint=str2byte(data.substring(1,7));
    if(data[0]=="1"){
      //必选，与之后必须等于原数
      if(dataint<=dataint&userint){
        //成功匹配
        return true;
      }else{
        return false;
      }
    }else if(data[0]=="0"){
      //选至少一项,与之后大于1
      if(dataint&userint>0){
        //成功匹配
        return true;
      }else{
        return false;
      }
    }else{
      //没有要求
      return true;
    }

  }
  bool compareSCHOOLNAME(String user,String data){
    if(user=="")return true;
    int data_len=data.length;
    int user_len=user.length;
    for(int i=0;i<data_len-user_len+1;i++){
      if(user==data.substring(i,user_len+i)){
        return true;
      }
    }
    return false;
  }
  bool compareSPECIALTYNAME(String user,String data){
    if(user=="")return true;
    int data_len=data.length;
    int user_len=user.length;
    for(int i=0;i<data_len-user_len+1;i++){
      if(user==data.substring(i,user_len+i)){
        return true;
      }
    }
    return false;
  }
  bool compareSCORE(int user,String data,int range){
    if(user==0||range==0)return true;
    int dataint=int.parse(data);
    try{
      if(user<=dataint+range&&user>=dataint-range){
        return true;
      }
    }catch(e){
      return false;
    }

    return false;
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
class OneNote{
  int id;
  String text;
  String date;
  OneNote(int i,String t,String d){
    id=i;
    text=t;
    date=d;
  }
  @override
  String toString() {
    // TODO: implement toString
    return "id:"+id.toString()+"\ntitle:"+text+"\ndate:"+date+"\n";
  }

}