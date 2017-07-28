
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

struct Handle {
    
    // 注册
    static func regist() -> RequestHandler {
        
        return {    request, response in
            
            var status: StatusCode = .SUCCESS
            var msg: String = "操作成功"
            var data: Any? = nil
            defer {
                let json = baseResponseJsonData(status: status, msg: msg, data: data)
                response.setHeader(.contentType, value: "application/json")
                response.appendBody(string: json)
                response.completed()
            }
        }
    }
    
    // 登陆
    static func login() -> RequestHandler {
        
        return {    request, response in
            
            var status: StatusCode = .SUCCESS
            var msg: String = "操作成功"
            var data: Any? = nil
            defer {
                let json = baseResponseJsonData(status: status, msg: msg, data: data)
                response.setHeader(.contentType, value: "application/json")
                response.appendBody(string: json)
                response.completed()
            }
        }
    }
}
