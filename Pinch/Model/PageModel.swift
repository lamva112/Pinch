//
//  PageModel.swift
//  Pinch
//
//  Created by bui khac lam on 14/03/2023.
//

import Foundation

struct Page : Identifiable {
    let id: Int
    let iamgeName: String
}

extension Page {
    var thumnailName: String {
        return "thumb-" + iamgeName
    }
}
