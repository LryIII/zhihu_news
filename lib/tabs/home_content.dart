import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  Map datall = {};
  List stories = [], _topStories = [];
  int dateNow = 0, mo = 0, da = 0;
  String addUrl=' ';
  _getData() async {
    Response response;
    var dio = Dio();
    response = await dio.get('https://news-at.zhihu.com/api/3/news/latest');
    if (response.statusCode == 200) {
      Map jsonResponse =response.data;
      setState(() {
        datall = jsonResponse;
        stories.addAll(datall["stories"]);
        _topStories = datall["top_stories"];
        dateNow = int.parse(datall["date"]);
        addUrl='http://news.at.zhihu.com/api/4/news/before/'+datall["date"];
        da = dateNow % 100;
        mo = (dateNow ~/ 100) % 100;
      });
    }
  }

  _addData() async {
    Response response;
    var dio = Dio();
    response = await dio.get(addUrl);
    if (response.statusCode == 200) {
      Map jsonResponse =response.data;
      setState(() {
        Map dateMap= {
          "image_hue": "0x2c2230",
          "title": jsonResponse["date"],
          "url": jsonResponse["stories"][0]["url"],
          "hint": "lryhhh",
          "ga_prefix": "121607",
          "images": [
            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwww.yidianzhidao.com%2FUploadFiles%2Fimg_2_1794357771_1636988519_26.jpg&refer=http%3A%2F%2Fwww.yidianzhidao.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1640429075&t=d814738beeac4e66b1396b1309d6f14c"
          ],
        };
        stories.add(dateMap);
        stories.addAll(jsonResponse["stories"]);
        addUrl='http://news.at.zhihu.com/api/4/news/before/'+jsonResponse["date"];
      });
    }
  }
  Map<String, String> month = {
    "1": "一月",
    "2": "二月",
    "3": "三月",
    "4": "四月",
    "5": "五月",
    "6": "六月",
    "7": "七月",
    "8": "八月",
    "9": "九月",
    "10": "十月",
    "11": "十一月",
    "12": "十二月",
  };

  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 500));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 500));
    // if failed,use loadFailed(),if no data return,use LoadData()
    if (mounted) {
      setState(() {
        _addData();
      });
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              "知乎日报",
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              width: 160.0,
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/login');
              },
              child: ClipOval(
                child: Container(
                  width: 35.0,
                  height: 35.0,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwww.yidianzhidao.com%2FUploadFiles%2Fimg_2_1794357771_1636988519_26.jpg&refer=http%3A%2F%2Fwww.yidianzhidao.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1640429075&t=d814738beeac4e66b1396b1309d6f14c"),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        leading: Column(
          children: [
            const SizedBox(
              height: 4,
            ),
            Text(
              "$da",
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              month[mo.toString()] ?? "0",
              style: const TextStyle(fontSize: 16.0, color: Colors.black),
            ),
          ],
        ),
      ),
      body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: const WaterDropHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = const Text("上拉加载");
              } else if (mode == LoadStatus.loading) {
                body = const CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = const Text("加载失败！点击重试！");
              } else if (mode == LoadStatus.canLoading) {
                body = const Text("松手,加载更多!");
              } else {
                body = const Text("没有更多数据了!");
              }
              return SizedBox(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.builder(
            itemCount: stories.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return topStoriesSwiper();
              }
              return storiesTile(index);
            },
            physics: const BouncingScrollPhysics(),
          )),
    );
  }
  Widget topStoriesSwiper(){
    return SizedBox(
      height: 250,
      width: 250,
      child: Swiper(
        itemCount: _topStories.length,
        itemBuilder: (BuildContext context, int index_1) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/details',
                  arguments: {"url": _topStories[index_1]["url"]});
              print(_topStories[index_1]["url"]);
            },
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0, 0),
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            _topStories[index_1]["image"]),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(-1, 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _topStories[index_1]["title"],
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _topStories[index_1]["hint"],
                        style: const TextStyle(
                          color: Colors.white38,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
        pagination: const SwiperPagination(
          alignment: Alignment.bottomRight,
        ),
        //control: SwiperControl(),
        loop: true,
        autoplay: true,
      ),
    );
  }
  Widget storiesTile(int index){
    if(stories[index-1]["hint"]=="lryhhh"){
      int date=int.parse(stories[index-1]["title"]);
      int day=date%100,month=date~/100%100;
      return SizedBox(
        height: 50,
        child:Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                  " $month月 $day日",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  )
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Container(
                  height: 1,
                  width: 257.7,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        //路由跳转
        Navigator.pushNamed(context, '/details',
            arguments: {"url": stories[index - 1]["url"]});
        //{"url":"www.baidu.com"});
      },
      child: Card(
        child: ListTile(
          title: Text(
            stories[index - 1]["title"],
            style: const TextStyle(fontSize: 18.0),
          ),
          subtitle: Text(
            stories[index - 1]["hint"] ?? "你好",
            style: const TextStyle(
              fontSize: 15.0,
              color: Colors.black38,
            ),
          ),
          trailing: Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(stories[index - 1]["images"][0]),
                fit: BoxFit.cover,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}
