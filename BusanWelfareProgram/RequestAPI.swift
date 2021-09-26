//
//  RequsetAPI.swift
//  BusanWelfareProgram
//
//  Created by jh on 2021/09/17.
//

import Foundation
import Alamofire
//import SwiftyJSON

struct fetchAPI {
    private init() { }
    static let shared = fetchAPI()
    func getData(numOfRows: Int, PageNo: Int, completion: @escaping (_ data: [Item]) -> Void) {
        
        guard let encodingKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else { return }
        
        let url = "http://apis.data.go.kr/6260000/SocialWelfareCenterProgramService/getProgramInfo?serviceKey=\(encodingKey)&numOfRows=\(numOfRows)&pageNo=\(PageNo)&resultType=json"
        
        
        AF.request(url, method: .get).responseJSON { response in
            //            print("response: \(response)")
            
            
            switch response.result {
            
            case .success(_):
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let welfareData = try decoder.decode(WelfareData.self, from: data)
                    //                    print(welfareData.getProgramInfo.item)
                    completion(welfareData.getProgramInfo.item)
                } catch { print("error \(error)") }
                
                
            // MARK: - SwiftyJSON 방식
            //                let json = JSON(jsonData)
            //                let result = json["getProgramInfo"].dictionaryValue["item"]?.arrayValue
            //                print(result!.count)
            //                completion(result)
            
            
            case .failure(let error):
                print("errorCode: \(error._code)")
                print("errorDescription: \(error.errorDescription!)")
            }
        }.resume()
    }
}
