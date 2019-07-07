//
//  ApiClient.swift
//  Elmenus
//
//  Created by New  on 7/5/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit

class ApiClient {

    private var request:URLRequest?

    private let urlSession:URLSession?
    
    init(httpMethod: HttpMethod = .get,
         params: [String:String]?=nil,
         headers: [String:String]?=nil,
         body: [String:Any]?=nil,
         apiPath:ApiPath,
         scheme:String = Util.scheme,
         host:String = Util.host,
         urlSession:URLSession = URLSession.shared) {
       
        let url = URLBuilder()
        .set(host: host)
        .set(scheme: scheme)
        .set(apiPath: apiPath)
        .addQueryParam(params: params)
        .build()

        if let url = url{
            request = RequestBuilder(url: url)
                .set(httpMethod: httpMethod)
                .set(headers: headers)
                .setBody(body: body)
                .build()
        }
        
        self.urlSession = urlSession
    }
    
    func genericFetch<T: Decodable>(completion:@escaping (Result<T,ApiError>)->Void)  {
        if let req = self.request {
            urlSession?.dataTask(with: req, completionHandler: { (data, response, error) in
                guard error == nil else {
                    completion(.failure(ApiError.error(error?.localizedDescription ?? "")))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse ,httpResponse.statusCode == 200 else {
                    completion(.failure(ApiError.serviceUnAvailable))
                        return
                    }
                

                guard let data = data
                    else {
                        completion(.failure(ApiError.invalidData))
                        return
                }
                do{
                    let model = try JSONDecoder().decode(T.self, from: data)
                    completion(.success((model)))
                }catch let jsonError{
                    print(jsonError)
                    completion(.failure(.invalidData))
                }
                
            }).resume()
        }
    }
}
