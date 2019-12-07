//
//  BundleExtension.swift
//  AVFoundationHelperRx_Example
//
//  Created by Nischal Hada on 6/12/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Foundation

extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? object(forInfoDictionaryKey: "CFBundleName") as? String
    }
}
