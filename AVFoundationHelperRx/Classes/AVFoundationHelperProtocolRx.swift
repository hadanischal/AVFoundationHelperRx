//
//  AVFoundationHelperProtocolRx.swift
//  AVFoundationHelperRx
//
//  Created by Nischal Hada on 6/12/19.
//

import RxSwift

public protocol AVFoundationHelperProtocolRx {
    // MARK: - Check and Respond to Camera Authorization Status
    var authorizationStatus: Single<AuthorizationStatus> { get }

    // MARK: - Request Camera Permission
    var requestAccess: Single<Bool> { get }
}
