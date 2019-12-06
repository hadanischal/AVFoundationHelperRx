//
//  AVFoundationHelperRx.swift
//  AVFoundationHelperRx
//
//  Created by Nischal Hada on 6/12/19.
//

import RxSwift
import AVFoundation

public final class AVFoundationHelperRx: AVFoundationHelperProtocolRx {

    // MARK: - Check and Respond to Camera Authorization Status

    public var authorizationStatus: Single<CameraStatus> {
        return Single<CameraStatus>.create { single in
            let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
            switch cameraAuthorizationStatus {
            case .notDetermined:
                single(.success(CameraStatus.notDetermined))
            case .authorized:
                single(.success(CameraStatus.authorized))
            case .restricted:
                single(.success(CameraStatus.restricted))
            case .denied:
                single(.success(CameraStatus.denied))
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
