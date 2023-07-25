//
//  NetworkManager.swift
//  ParisSportifsProject
//
//  Created by Zakaria El Mouatassim on 24/07/2023.
//

import Alamofire
import Foundation

public class NetworkManager {
    public static let shared = NetworkManager()

    func getAllLeagues(complitionHandler: @escaping (Leagues?, Error?) -> Void) {
        AF.request(Constants.BASE_URL + Constants.GET_ALL_Leagues).responseDecodable(of: Leagues.self) { (response) in
            switch response.result {
            case .success(let leagues):
                complitionHandler(leagues, nil)
            case .failure(let error):
                complitionHandler(nil, error)
            }
        }
    }

    func getTeamsByLeague(strLeague: String, complitionHandler: @escaping (Teams?, Error?) -> Void) {
        let parameters = ["l" : strLeague] as [String : String]
        AF.request(Constants.BASE_URL + Constants.GET_League_Teams, parameters: parameters).responseDecodable(of: Teams.self) { (response) in

            switch response.result {
            case .success(let teams):
                complitionHandler(teams, nil)
            case .failure(let error):
                complitionHandler(nil, error)
            }
        }
    }
}
