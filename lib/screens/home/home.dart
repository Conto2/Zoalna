import 'dart:async';
import 'dart:io';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:shared_preferences/shared_preferences.dart'; // لتخزين معلومات تسجيل الدخول محلياً
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zoalna/screens/utils/constants.dart';
import 'package:zoalna/widgets/shimmer.dart';
import 'package:lottie/lottie.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  InAppWebViewController? webViewController;
  String url = "https://zoalna.sd";
  double progress = 0;
  bool _isLoading = true;
  bool isError = false;
  String errorMessage = "error conto 1";
  int _currentIndex = 0;

  ////
  PageController? _pageController;

  final List<String> allowedDomains = [
    "https://zoalna.sd",
    "https://google.com",
  ];

  bool isLoggedIn = false;
  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    _loadLoginStatus();
  }

  void openGoogleSignIn() async {
    final Uri googleSignInUrl = Uri.parse("https://m.me/103125285840446");

    if (await canLaunchUrl(googleSignInUrl)) {
      await launch(
        googleSignInUrl.toString(),
        enableJavaScript: true,
        enableDomStorage: true,
      );
    } else {
      print("لا يمكن فتح الرابط");
    }
  }

  Future<void> _loadLoginStatus() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs?.getBool("isLoggedIn") ?? false;
    });
  }

  Future<void> _setLoginStatus(bool status) async {
    await prefs?.setBool("isLoggedIn", status);
    setState(() {
      isLoggedIn = status;
    });
  }

  void _onChildTap(BuildContext context, String title) {
    webViewController?.loadUrl(urlRequest: URLRequest(url: WebUri(title)));
    Navigator.pop(context);
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text('تم النقر على: $title')),
    // );
  }

  Future<bool> _hasInternet() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  void _reloadPage() async {
    bool connected = await _hasInternet();
    if (connected) {
      webViewController?.reload();
      setState(() {
        isError = false;
        errorMessage = "error";
      });
    } else {
      setState(() {
        isError = true;
        errorMessage = "لا يوجد اتصال بالإنترنت";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (webViewController != null) {
          bool canGoBack = await webViewController!.canGoBack();
          if (canGoBack) {
            await webViewController!.goBack();
            return false; // منع إغلاق التطبيق
          }
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            "Zoalna",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: WebUri("https://zoalna.sd/cart-2/ ")));
              },
              child: Container(
                  margin: EdgeInsets.only(
                    right: 10,
                    left: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 2,
                        spreadRadius: 1,
                        color: Colors.black12,
                      )
                    ],
                  ),
                  child: Image.asset(
                    'assets/icons/Buy@2x.png',
                    height: 23,
                    color: Constants.Primarycolor,
                  )),
            ),
            InkWell(
              onTap: () {
                _reloadPage();
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: 10,
                  top: 5,
                  left: 15,
                  bottom: 5,
                ),
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 1,
                      color: Colors.black12,
                    )
                  ],
                ),
                child: SvgPicture.asset(
                  'assets/svg/Trackorder.svg',
                  color: Constants.Primarycolor,
                  height: 28,
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          elevation: 1,
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                padding: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  color: Constants.Primarycolor,
                ),
                child: Column(
                  children: [
                    Text("القائمة",
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    SizedBox(height: 30),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 70,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20),
              ListTile(
                title: Text("الرئسيه "),
                onTap: () {
                  webViewController?.loadUrl(
                      urlRequest:
                          URLRequest(url: WebUri("https://zoalna.sd/")));
                  //   _extractData();
                  Navigator.pop(context);
                },
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: double.infinity,
                  height: 0.5,
                  color: Constants.Primarycolor.withOpacity(0.5)),
              ListTile(
                title: Text("كيفيه استخدام التطبيق"),
                onTap: () {
                  webViewController?.loadUrl(
                      urlRequest: URLRequest(
                          url: WebUri(
                    "https://zoalna.sd/use-store/",
                  )));
                  //   _extractData();
                  Navigator.pop(context);
                },
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: double.infinity,
                  height: 0.5,
                  color: Constants.Primarycolor.withOpacity(0.5)),
              ExpansionTile(
                title: const Text('بعض الألعاب'),
                children: [
                  ListTile(
                    title: const Text('فري فاير',
                        style: TextStyle(fontSize: 16, color: Colors.black45)),
                    onTap: () => _onChildTap(context,
                        'https://zoalna.sd/product-category/free-fire/'),
                  ),
                  ListTile(
                    title: const Text('ببجي',
                        style: TextStyle(fontSize: 16, color: Colors.black45)),
                    onTap: () => _onChildTap(context,
                        ' https://zoalna.sd/product-category/%d8%a8%d8%a8%d8%ac%d9%8a-%d9%85%d9%88%d8%a8%d8%a7%d9%8a%d9%84/'),
                  ),
                  ListTile(
                    title: const Text('ماستر كارد',
                        style: TextStyle(fontSize: 16, color: Colors.black45)),
                    onTap: () => _onChildTap(context,
                        'https://zoalna.sd/product-category/%d8%a8%d8%b7%d8%a7%d9%82%d8%a7%d8%aa-%d9%85%d8%a7%d8%b3%d8%aa%d8%b1-%d9%83%d8%a7%d8%b1%d8%af-%d8%a7%d9%81%d8%aa%d8%b1%d8%a7%d8%b6%d9%8a%d8%a9-%d9%81%d9%8a-%d8%a7%d9%84%d8%b3%d9%88%d8%af%d8%a7%d9%86-m/'),
                  ),
                  ListTile(
                    title: const Text('ريزر قولد',
                        style: TextStyle(fontSize: 16, color: Colors.black45)),
                    onTap: () => _onChildTap(context,
                        ' https://zoalna.sd/product-category/%d8%b1%d9%8a%d8%b2%d8%b1-%d9%82%d9%88%d9%84%d8%af/'),
                  ),
                  ListTile(
                    title: const Text('الايتونز',
                        style: TextStyle(fontSize: 16, color: Colors.black45)),
                    onTap: () => _onChildTap(context,
                        'https://zoalna.sd/product-category/%d8%a7%d9%8a%d8%aa%d9%88%d9%86%d8%b2/'),
                  ),
                  ListTile(
                    title: const Text('نتفلكس',
                        style: TextStyle(fontSize: 16, color: Colors.black45)),
                    onTap: () => _onChildTap(context,
                        'https://zoalna.sd/product-category/%d9%86%d8%aa%d9%81%d9%84%d9%83%d8%b3/'),
                  ),
                ],
              ),

              // العنصر الرئيسي الثاني (أب)

              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: double.infinity,
                  height: 0.5,
                  color: Constants.Primarycolor.withOpacity(0.5)),
              // ---------------------------
              ExpansionTile(
                title: const Text('الشحن بالايدي'),
                children: [
                  ListTile(
                    title: const Text(
                      'شحن فري فاير',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                    onTap: () => _onChildTap(
                        context, 'https://zoalna.sd/product/free-fire-id/'),
                  ),
                  ListTile(
                    title: const Text(
                      'شحن ببجي',
                      style: TextStyle(fontSize: 16, color: Colors.black45),
                    ),
                    onTap: () => _onChildTap(
                        context, 'https://zoalna.sd/product/pubg-id/'),
                  ),
                  ListTile(
                    title: const Text('شحن يلا ليدو',
                        style: TextStyle(fontSize: 16, color: Colors.black45)),
                    onTap: () => _onChildTap(
                        context, 'https://zoalna.sd/product/yalla-ludo-id/'),
                  ),
                  ListTile(
                    title: const Text('شحن جواكر',
                        style: TextStyle(fontSize: 16, color: Colors.black45)),
                    onTap: () => _onChildTap(
                        context, 'https://zoalna.sd/product/jawaker/'),
                  ),
                  ListTile(
                    title: const Text('موبايل ليجند',
                        style: TextStyle(fontSize: 16, color: Colors.black45)),
                    onTap: () => _onChildTap(
                        context, 'https://zoalna.sd/product/mobile-legends/'),
                  ),
                  ListTile(
                    title: const Text('شحن عملات تيك توك ',
                        style: TextStyle(fontSize: 16, color: Colors.black45)),
                    onTap: () => _onChildTap(
                        context, 'https://zoalna.sd/product/tik-tok-offers/'),
                  ),
                ],
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: double.infinity,
                  height: 0.5,
                  color: Constants.Primarycolor.withOpacity(0.5)),
              ListTile(
                title: Text("الطلبات"),
                onTap: () {
                  webViewController?.loadUrl(
                      urlRequest: URLRequest(
                          url: WebUri(
                    "https://zoalna.sd/my-account-2/orders/",
                  )));
                  //   _extractData();
                  Navigator.pop(context);
                },
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: double.infinity,
                  height: 0.5,
                  color: Constants.Primarycolor.withOpacity(0.5)),

              ListTile(
                title: Text("تسجيل دخول / انشاء حساب"),
                onTap: () {
                  webViewController?.loadUrl(
                      urlRequest: URLRequest(
                          url: WebUri(
                    "https://zoalna.sd/my-account-2/",
                  )));
                  //   _extractData();
                  Navigator.pop(context);
                },
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: double.infinity,
                  height: 0.5,
                  color: Constants.Primarycolor.withOpacity(0.5)),

              // يمكنك إضافة عناصر أخرى حسب الحاجة

              ListTile(
                title: Text("سياسه الخصوصيه"),
                onTap: () {
                  webViewController?.loadUrl(
                      urlRequest: URLRequest(
                          url: WebUri(
                    "https://zoalna.sd/privacy-policy/",
                  )));
                  // مثال على استخراج البيانات من صفحة الويب عند الضغط على عنصر القائمة
                  //   _extractData();
                  Navigator.pop(context);
                },
              ),

              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: double.infinity,
                  height: 0.5,
                  color: Constants.Primarycolor.withOpacity(0.5)),

              ListTile(
                title: Text("حسابي"),
                onTap: () {
                  webViewController?.loadUrl(
                      urlRequest: URLRequest(
                          url: WebUri(
                    "https://zoalna.sd/my-account-2/",
                  )));
                  // مثال على استخراج البيانات من صفحة الويب عند الضغط على عنصر القائمة
                  //   _extractData();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              isError
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(errorMessage,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.red)),
                          SizedBox(height: 20),
                          Container(
                            height: 180,
                            child: LottieBuilder.asset(
                              'assets/lottie/offline.json',
                              fit: BoxFit.contain,
                              // delegates: LottieDelegates(values: [
                              //   ValueDelegate.color(
                              //     ['**'],
                              //     value: Constants.Primarycolor,
                              //   )
                              // ]),
                              animate: true,
                              // height: 30,

                              repeat: true,
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _reloadPage,
                            child: Text(
                              "إعادة المحاولة",
                              style: TextStyle(color: Constants.Primarycolor),
                            ),
                          )
                        ],
                      ),
                    )
                  : InAppWebView(
                      initialUrlRequest: URLRequest(
                        url: WebUri(
                          isLoggedIn
                              ? "https://zoalna.sd/"
                              : "https://zoalna.sd/my-account-2/",
                        ),
                        // إذا كان المستخدم مسجلاً للدخول، يمكن توجيهه لموقع مختلف
                      ),
                      initialSettings: InAppWebViewSettings(
                        javaScriptEnabled: true,
                        supportMultipleWindows: true,
                        javaScriptCanOpenWindowsAutomatically: true,
                        thirdPartyCookiesEnabled: true,
                        cacheEnabled: true,
                        domStorageEnabled: true,
                      ),

                      shouldOverrideUrlLoading:
                          (controller, navigationAction) async {
                        final uri = navigationAction.request.url;

                        if (uri != null) {
                          String urlString = uri.toString();

                          // ✅ فتح تطبيق الماسنجر عند الضغط على رابط Messenger
                          if (urlString.contains("m.me") ||
                              urlString.contains("facebook.com/messages")) {
                            final messengerUri =
                                Uri.parse("fb-messenger://user/");
                            if (await canLaunchUrl(messengerUri)) {
                              await launch(' https://m.me/103125285840446');
                              return NavigationActionPolicy
                                  .CANCEL; // منع WebView من تحميل الرابط
                            }
                          }

                          if (urlString
                              .startsWith("https://m.me/103125285840446")) {
                            String fallbackUrl =
                                "https://play.google.com/store/apps/details?id=com.facebook.orca"; // رابط تحميل الماسنجر إذا لم يكن مثبتًا
                            final intentUri = Uri.parse(urlString);
                            if (await canLaunchUrl(intentUri)) {
                              // ignore: deprecated_member_use
                              await launch('https://m.me/103125285840446');
                            } else {
                              await launch(
                                (fallbackUrl),
                              );
                            }
                            return NavigationActionPolicy.CANCEL;
                          }
                        }

                        return NavigationActionPolicy
                            .ALLOW; // السماح للروابط الأخرى بالتحميل
                      },

                      onLoadResource: (controller, resource) async {
                        if (resource.url
                            .toString()
                            .contains("accounts.google.com")) {
                          openGoogleSignIn(); // فتح تسجيل الدخول في متصفح خارجي
                        }
                      },
                      // ignore: deprecated_member_use
                      initialOptions: InAppWebViewGroupOptions(
                        // ignore: deprecated_member_use
                        crossPlatform: InAppWebViewOptions(
                          javaScriptCanOpenWindowsAutomatically: true,
                          javaScriptEnabled: true,
                          cacheEnabled: true,
                          supportZoom: true,
                          disableHorizontalScroll: false,
                          disableVerticalScroll: false,
                        ),
                        // ignore: deprecated_member_use
                        android: AndroidInAppWebViewOptions(
                          useHybridComposition: true,
                        ),
                        // ignore: deprecated_member_use
                        ios: IOSInAppWebViewOptions(),
                      ),

                      onWebViewCreated: (controller) {
                        webViewController = controller;

                        webViewController?.addJavaScriptHandler(
                            handlerName: "loginHandler",
                            callback: (args) {
                              _setLoginStatus(true);
                              return {"status": "success"};
                            });
                      },

                      // عند بدء تحميل الصفحة
                      onLoadStart: (controller, url) {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(content: Text('بدء التحميل ...')),
                        // );
                        setState(() {
                          _isLoading = true;
                          this.url = url.toString();
                        });
                      },
                      onLoadStop: (controller, url) async {
                        setState(() {
                          _isLoading = false;
                          this.url = url.toString();
                        });
                        String? pageTitle = await controller.getTitle();
                        print("عنوان الصفحة: $pageTitle");
                        await controller.evaluateJavascript(source: """
          document.querySelector('.wd-toolbar').style.display = 'none';
          document.querySelector('.wd-tools-element').style.display = 'none';
          document.querySelector('.footer-container').style.display = 'none';
          document.querySelector('.whb-header').style.display = 'none';
          document.querySelector('.google-login-wrapper').style.display = 'none';
          document.querySelector('.on-hover-text').style.display = 'none';
        """);
                      },
                      onLoadError: (controller, url, code, message) {
                        setState(() {
                          isError = true;
                          _isLoading = false;
                          ;
                          errorMessage = "خطأ في تحميل الصفحة:";
                        });
                      },
                      onProgressChanged: (controller, progress) {
                        setState(() {
                          this.progress = progress / 100;
                        });
                      },
                      onUpdateVisitedHistory:
                          (controller, url, androidIsReload) {
                        setState(() {
                          this.url = url.toString();
                        });
                      },
                      onConsoleMessage: (controller, consoleMessage) {
                        print(consoleMessage);
                      },
                    ),
              progress < 1.0
                  ? Container(
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: LinearProgressIndicator(
                        value: progress,
                        borderRadius: BorderRadius.circular(20),
                        color: Constants.Primarycolor,
                        backgroundColor:
                            Constants.Primarycolor.withOpacity(0.2),
                      ),
                    )
                  : Container(),
              if (_isLoading)
                Container(
                  color: Colors.white,
                  child: Center(
                    child: SizedBox(
                      child: this.url == 'https://zoalna.sd/'
                          ? ShimmerExampleItems()
                          : Container(
                              height: 80,
                              child: LottieBuilder.asset(
                                'assets/lottie/loading1.json',
                                fit: BoxFit.contain,
                                delegates: LottieDelegates(values: [
                                  ValueDelegate.color(
                                    ['**'],
                                    value: Constants.Primarycolor,
                                  )
                                ]),
                                animate: true,
                                // height: 30,

                                repeat: true,
                              ),
                            ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          // : EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                spreadRadius: 2,
                color: Colors.black12,
              )
            ],
          ),
          padding: EdgeInsets.only(top: 5, right: 5, left: 5),
          margin: EdgeInsets.only(right: 2, left: 2),

          child: DotNavigationBar(
            duration: Duration(seconds: 1),
            curve: Curves.decelerate,
            enablePaddingAnimation: false,
            splashColor: Colors.black.withOpacity(0.2),
            backgroundColor: Colors.white,
            margin: EdgeInsets.only(left: 10, right: 10),
            currentIndex: _currentIndex,
            dotIndicatorColor: Colors.red,
            splashBorderRadius: 50,
            enableFloatingNavBar: false,
            //  onTap: _handleIndexChanged,
            onTap: (int i) {
              setState(() => _currentIndex = i);
              _pageController?.jumpToPage(i);
              if (_currentIndex == 0) {
                webViewController?.loadUrl(
                    urlRequest: URLRequest(url: WebUri("https://zoalna.sd/")));
              } else if (_currentIndex == 1) {
                webViewController?.loadUrl(
                    urlRequest: URLRequest(
                        url: WebUri("https://zoalna.sd/my-account-2/orders/")));
              } else if (_currentIndex == 2) {
                webViewController?.loadUrl(
                    urlRequest: URLRequest(
                        url: WebUri(
                            "https://zoalna.sd/my-account-2/woo-wallet/")));
              } else if (_currentIndex == 3) {
                webViewController?.loadUrl(
                    urlRequest: URLRequest(
                        url: WebUri("https://zoalna.sd/my-account-2/")));
              }
              print(_currentIndex);
            },
            items: [
              /// Home
              ///
              DotNavigationBarItem(
                icon: Container(
                    height: 48,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/icons/bhome.png',
                          height: 26,
                          color: Constants.Primarycolor.withOpacity(0.8),
                        ),
                        Text(
                          'الرئسيه',
                          style: TextStyle(
                              fontSize: 14, color: Constants.Primarycolor),
                        ),
                      ],
                    )),
              ),

              /// Transaction history
              DotNavigationBarItem(
                icon: Container(
                    margin: EdgeInsets.only(right: 20),
                    height: 48,
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/Order.svg',
                          color: Constants.Primarycolor.withOpacity(0.8),
                          height: 27,
                        ),
                        Text(
                          'الطلبات',
                          style: TextStyle(
                              fontSize: 14, color: Constants.Primarycolor),
                        ),
                      ],
                    )),
              ),

              /// TopUp
              DotNavigationBarItem(
                icon: Container(
                    height: 48,
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/Wallet.svg',
                          color: Constants.Primarycolor.withOpacity(0.8),
                          height: 24,
                        ),
                        Text(
                          'محفظتي',
                          style: TextStyle(
                              fontSize: 14, color: Constants.Primarycolor),
                        ),
                      ],
                    )),
              ),

              /// Profile
              DotNavigationBarItem(
                icon: Container(
                    height: 48,
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/Profile.svg',
                          color: Constants.Primarycolor.withOpacity(0.8),
                          height: 27,
                        ),
                        Text(
                          'حسابي',
                          style: TextStyle(
                              fontSize: 14, color: Constants.Primarycolor),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            webViewController?.loadUrl(
                urlRequest:
                    URLRequest(url: WebUri("https://zoalna.sd/cart-2/ ")));
          },
          backgroundColor: Constants.Primarycolor.withOpacity(0.8),
          // tooltip: 'conversations'.tr(),
          child: Image.asset(
            'assets/icons/Bag@2x.png',
            color: Colors.white,
            height: 28,
          ),
          shape: CircleBorder(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
