//
//  CountryService.swift
//  Countries
//
//  Created by Ali Eren on 1.09.2022.
//

import Foundation
import Alamofire

final class CountryService {
    
    static let shared = CountryService()
    static let apiKey = "c3f6211f04msh75f9c45ec80161ap137ffajsn491a9ac1537e"
    static let baseURL = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries"
    static let host = "wft-geo-db.p.rapidapi.com"
    
    let headers: HTTPHeaders = [
        "X-RapidAPI-Key": "\(apiKey)",
        "X-RapidAPI-Host": "\(host)"
    ]
    
    let parameters: Parameters = [
        "limit": "10"
    ]
    
    func getCountryList(completion: @escaping (Result<CountryList, Error>) -> Void ) {
        guard let requestURL = URL(string: CountryService.baseURL) else { return }
        AF.request(requestURL,parameters:parameters,encoding: URLEncoding(destination: .queryString), headers: headers).responseDecodable(of: CountryList.self) { response in
            switch response.result {
            case .success:
                if let value = response.value {
                    completion(.success(value))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCountryDetail(code: String, completion: @escaping (Result<DataClass, Error>) -> Void) {
        guard let requestURL = URL(string: CountryService.baseURL + "/\(code)") else { return }
        AF.request(requestURL,encoding: URLEncoding(destination: .queryString), headers: headers).responseDecodable(of: DataClass.self) { response in
            switch response.result {
            case .success:
                if let value = response.value {
                    completion(.success(value))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
