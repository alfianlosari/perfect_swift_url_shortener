//
//  Handlers.swift
//  url_shortener
//
//  Created by Alfian Losari on 22/07/17.
//
//

import PerfectLib
import PerfectHTTP
import PerfectMustache
import SQLite
import SwiftString

struct IndexHandler: MustachePageHandler {
    
    func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
        
        var values = MustacheEvaluationContext.MapType()
        
        let dbHandler = DB()
        let data = dbHandler.getList()
        var ary = [Any]()
        for i in 0..<data.count {
            var thisURL = [String: String]()
            thisURL["id"] = data[i].id
            thisURL["url"] = data[i].url
            thisURL["sanity"] = data[i].sanity
            ary.append(thisURL)
        }
        
        values["urls"] = ary
        contxt.extendValues(with: values)
        do {
            try contxt.requestCompleted(withCollector: collector)
        } catch {
            let response = contxt.webResponse
            response.status = .internalServerError
            response.appendBody(string: "\(error)")
            response.completed()
        }
        
    }

}


struct URLSHandler: MustachePageHandler {

     func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
     
        var values = MustacheWebEvaluationContext.MapType()
        let request = contxt.webRequest
        
        let urlInput = request.param(name: "url", defaultValue: "http://")!
        let dbHandler = DB()
        
        if !urlInput.isEmpty && urlInput != "http://" {
            let newURL = URLify(urlInput)
            print("New URL: \(newURL.id), \(newURL.url), \(newURL.sanity)")
            let _ = dbHandler.saveURL(newURL)
            
        }
        
        let data = dbHandler.getList()
    
        var ary = [Any]()
        for i in 0..<data.count {
            var thisURL = [String: String]()
            thisURL["id"] = data[i].id
            thisURL["url"] = data[i].url
            thisURL["sanity"] = data[i].sanity
            ary.append(thisURL)
        }
        
        values["urls"] = ary
        contxt.extendValues(with: values)
        
        do {
            try contxt.requestCompleted(withCollector: collector)
        } catch {
            let response = contxt.webResponse
            response.status = .internalServerError
            response.appendBody(string: "\(error)")
            response.completed()
            
            
            
        }
        
        
        
        
        
    }
    
    
}




