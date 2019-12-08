//
//  AVFoundationHelperRx.swift
//  AVFoundationHelperRx
//
//  Created by Nischal Hada on 6/12/19.
//

import RxSwift
import AVFoundation

public final class AVFoundationHelperRx: AVFoundationHelperProtocolRx {

    public init() {}

    // MARK: - Check and Respond to Camera Authorization Status

    public var authorizationStatus: Single<AuthorizationStatus> {
        return Single<AuthorizationStatus>.create { single in
            let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
            switch cameraAuthorizationStatus {
            case .notDetermined:
                single(.success(AuthorizationStatus.notDetermined))
            case .authorized:
                single(.success(AuthorizationStatus.authorized))
            case .restricted:
                single(.success(AuthorizationStatus.restricted))
            case .denied:
                single(.success(AuthorizationStatus.denied))
            @unknown default:
                fatalError("AVCaptureDevice.authorizationStatus is not available on this version of OS.")
            }
            return Disposables.create()
        }
    }

    // MARK: - Request Camera Permission

    public var requestAccess: Single<Bool> {
        return Single<Bool>.create { single in
            AVCaptureDevice.requestAccess(for: .video, completionHandler: {accessGranted in
                single(.success(accessGranted))
            })
            return Disposables.create()
        }
    }
}
