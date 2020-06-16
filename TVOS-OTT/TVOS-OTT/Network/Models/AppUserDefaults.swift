//
//  AppUserDefaults.swift
//  TVOS-OTT
//
//  Created by Souvik on 16/06/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import Foundation

import Foundation

let programsKey = "Programs"
let programsCountKey = "ProgramsCount"

extension UserDefaults {

    /// Store and Get programs.
    class func getFavouriteList() -> [FavouriteModel]? {

        let defaults = UserDefaults.standard
        if let programsData = defaults.object(forKey: programsKey) as? Data {
            let decoder = JSONDecoder()
            if let programs = try? decoder.decode([FavouriteModel].self, from: programsData) {
                return programs
            }
        }
        return nil
    }

    class func storeFavouriteList(programs: [FavouriteModel]) {

        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(programs) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: programsKey)
        }
    }

    class func getDefaultFavouriteCount() -> Int {

        let defaults = UserDefaults.standard
        if let programsCount = defaults.object(forKey: programsCountKey) as? Int {
            return programsCount
        }
        return 0
    }

    class func storeDefaultFavCount(count: Int) {

        let defaults = UserDefaults.standard
        defaults.set(count, forKey: programsCountKey)
    }
}
