//
//  FileManager-DocumentsDirectory.swift
//  MorningBrew
//
//  Created by Sarthak Agrawal on 01/09/23.
//

import Foundation

extension FileManager{
    static var documentDirectory:URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
