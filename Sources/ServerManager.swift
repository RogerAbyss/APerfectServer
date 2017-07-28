//
//  ServerManager.swift
//  APerfectServer
//
//  Created by abyss on 2017/7/28.
//
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

enum StatusCode: Int {
    case Faile = -1
    case SUCCESS = 1
}

class ServerManager {
    
    private var server = HTTPServer()
    
    init(root: String = "./webroot", host: String, port: UInt16) {
        
        server.documentRoot = root
        server.serverPort = port
        server.serverAddress = host
        
        var routes = Routes()
        configRoutes(routes: &routes)
        server.addRoutes(routes)
        
    }
    
    func startServer() {
        do {
            try server.start()
        } catch PerfectError.networkError(let error, let msg) {
            print("网络出现错误: \(error) \(msg)")
        } catch {
            print("网络未知错误:\(error)")
        }
        
    }
    
    
    func configRoutes(routes: inout Routes) {
    
        // 增加静态根路径
        do {
            routes.add(method:.get, uri:"/**", handler:try PerfectHTTPServer.HTTPHandler.staticFiles(data: [:]))
            
            routes.add(method: .get, uri: "/login", handler: Handle.login())
            routes.add(method: .get, uri: "/regist", handler: Handle.regist())
        }
        catch {
            print(error)
        }
    }
}

/// 通用响应格式
func baseResponseJsonData(status: StatusCode, msg: String, data: Any?) -> String {
    
    var result = [String: Any]()
    result.updateValue(status.rawValue, forKey: "status")
    result.updateValue(msg, forKey: "msg")
    if data != nil {
        result.updateValue(data!, forKey: "data")
    }else {
        result.updateValue("", forKey: "data")
    }
    
    guard let json = try? result.jsonEncodedString() else{
        return ""
    }
    
    print(json);
    return json
}

/// 过滤某些响应
struct FilterResponse: HTTPResponseFilter {
    
    func filterHeaders(response: HTTPResponse, callback: (HTTPResponseFilterResult) -> ()) {
        switch response.status {
        case .notFound:// 过滤404
            response.setBody(string: "404")
        default:
            callback(.continue)
        }
    }
    
    func filterBody(response: HTTPResponse, callback: (HTTPResponseFilterResult) -> ()) {
        callback(.continue)
    }
}
