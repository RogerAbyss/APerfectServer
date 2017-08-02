
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
    
    static func config() -> RequestHandler {
        
        return {    request, response in
            
            var status: StatusCode = .SUCCESS
            var msg: String = "操作成功"
            var data: Any? = nil
            defer {
                response.isStreaming = true
                
                let file = File("/Users/abyss/Desktop/config.json")
                
                var bytes = [UInt8.init("哈哈")]
                if file.exists {
                    do {
                        bytes = try file.readSomeBytes(count: file.size)
                    } catch {
                        print("ERROR FILE")
                    }
                }
                
                response.setHeader(.contentDisposition, value: "attachment;filename*=charset'utf-8'config.json")
                response.appendBody(bytes: bytes as! [UInt8])
                response.completed()
            }
        }
    }
}
