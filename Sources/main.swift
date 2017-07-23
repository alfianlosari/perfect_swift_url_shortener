import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PerfectMustache

let server = HTTPServer();
server.documentRoot = "./webroot"
var routes = Routes()

let dbHandler = DB()
dbHandler.create()

routes.add(method: .get, uri: "/") { (request, response) in
    response.setHeader(.contentType, value: "text/html")
    mustacheRequest(request: request, response: response, handler: IndexHandler(), templatePath: request.documentRoot + "/index.mustache")
    response.completed()
}

routes.add(method: .post, uri: "/") { (request, response) in
    response.setHeader(.contentType, value: "text/html")
    mustacheRequest(request: request, response: response, handler: URLSHandler(), templatePath: request.documentRoot + "/index.mustache")
    response.completed()
}

routes.add(method: .get, uri: "/to/{sanity}") { (request, response) in
    let sanity = request.urlVariables["sanity"] ?? ""
    var destination = "/"
    if !sanity.isEmpty {
        let urlObj = dbHandler.getURL(sanity)
        destination = urlObj
        if destination.isEmpty {
            destination = "/"
        }
    }
    
    print("Redirecting /to/\(sanity.lowercased()) to \(destination)")
    response.setHeader(.contentType, value: "text/html")
    response.status = .found
    response.setHeader(.location, value: destination)
    response.completed()
    
    
    
}

server.addRoutes(routes)
server.serverPort = 8181

do {
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}
