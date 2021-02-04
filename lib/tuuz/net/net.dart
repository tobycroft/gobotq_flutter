import 'dart:convert';
import 'dart:io';

import 'package:gobotq_flutter/config/config.dart';

class Net {
  Future<String> Post(String url, path, Map<String, String> get, Map<String, String> post, Map<String, String> header) async {
    var http = new HttpClient();
    if (Config().Proxy_debug) {
      http.findProxy = (url) {
        return HttpClient.findProxyFromEnvironment(url, environment: {"http_proxy": Config().ProxyURL});
      };
    }
    var uri;
    if (get == null || get.isEmpty) {
      uri = new Uri.http(url, path);
    } else {
      uri = new Uri.http(url, path, get);
    }
    var query = new Uri(queryParameters: post);
    var req = await http.postUrl(uri);
    if (header != null && !header.isEmpty) {
      header.forEach((key, value) {
        req.headers.add(key, value);
      });
    }
    req.headers.contentType = ContentType.parse("application/x-www-form-urlencoded");
    req.write(query.query);
    var resp = await req.close();
    var ret = await resp.transform(utf8.decoder).join();
    return ret;
  }

  Future<String> PostRaw(String url, path, Map<String, String> get, dynamic post, Map<String, String> header) async {
    var http = new HttpClient();
    if (Config().Proxy_debug) {
      http.findProxy = (url) {
        return HttpClient.findProxyFromEnvironment(url, environment: {"http_proxy": Config().ProxyURL});
      };
    }
    var uri;
    if (get == null || get.isEmpty) {
      uri = new Uri.http(url, path);
    } else {
      uri = new Uri.http(url, path, get);
    }
    var req = await http.postUrl(uri);
    if (header != null && !header.isEmpty) {
      header.forEach((key, value) {
        req.headers.add(key, value);
      });
    }
    req.headers.contentType = ContentType.text;
    req.write(post);
    var resp = await req.close();
    var ret = await resp.transform(utf8.decoder).join();
    return ret;
  }

  Future<String> PostJson(String url, path, Map<String, String> get, Map<String, dynamic> post, Map<String, String> header) async {
    var http = new HttpClient();
    if (Config().Proxy_debug) {
      http.findProxy = (url) {
        return HttpClient.findProxyFromEnvironment(url, environment: {"http_proxy": Config().ProxyURL});
      };
    }
    var uri;
    if (get == null || get.isEmpty) {
      uri = new Uri.http(url, path);
    } else {
      uri = new Uri.http(url, path, get);
    }
    var req = await http.postUrl(uri);
    if (header != null && !header.isEmpty) {
      header.forEach((key, value) {
        req.headers.add(key, value);
      });
    }
    req.headers.contentType = ContentType.text;
    req.writeln(post);
    var resp = await req.close();
    var ret = await resp.transform(utf8.decoder).join();
    return ret;
  }

  Future<String> Get(String url, path, Map<String, String> get, Map<String, String> header) async {
    var http = new HttpClient();
    if (Config().Proxy_debug) {
      http.findProxy = (url) {
        return HttpClient.findProxyFromEnvironment(url, environment: {"http_proxy": Config().ProxyURL});
      };
    }
    var uri;
    if (get == null || get.isEmpty) {
      uri = new Uri.http(url, path);
    } else {
      uri = new Uri.http(url, path, get);
    }
    var req = await http.getUrl(uri);
    if (header != null && !header.isEmpty) {
      header.forEach((key, value) {
        req.headers.add(key, value);
      });
    }
    req.headers.contentType = ContentType.parse("application/x-www-form-urlencoded");
    var resp = await req.close();
    var ret = await resp.transform(utf8.decoder).join();
    return ret;
  }
}
