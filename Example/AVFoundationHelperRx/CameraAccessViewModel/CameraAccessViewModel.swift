//
//  CameraAccessViewModel.swift
//  AVFoundationHelperRx_Example
//
//  Created by Nischal Hada on 6/12/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import Foundation
import RxSwift
import AVFoundationHelperRx

enum CameraAccessRoute {
    case showCameraReader
    case alertCameraAccessNeeded
}

protocol CameraAccessDataSource: class {
    func transformInput(linkButtonTaps taps: Observable<Void>) -> Observable<CameraAccessRoute>
}

final class CameraAccessViewModel: CameraAccessDataSource {

    private let avFoundation: AVFoundationHelperProtocolRx

    init(avFoundation: AVFoundationHelperProtocolRx = AVFoundationHelperRx()) {
        self.avFoundation = avFoundation
    }

    func transformInput(linkButtonTaps taps: Observable<Void>) -> Observable<CameraAccessRoute> {
        taps.asObservable()
            .flatMap({ [weak self] _ -> Observable<CameraAccessRoute> in
                return self?.handelCameraAccessButtonTaps() ?? Observable.error(RxError.unknown)
            })
    }

    private func handelCameraAccessButtonTaps() -> Observable<CameraAccessRoute> {
        avFoundation.authorizationStatus
            .asObservable()
            .flatMap({ [weak self] status -> Observable<CameraAccessRoute> in
                guard let self = self else { return Observable.error(RxError.unknown)}

                switch status {
                case .notDetermined:
                    return self.requestAccess()

                case .authorized:
                    return Observable.just(CameraAccessRoute.showCameraReader)

                case .restricted, .denied:
                    return Observable.just(CameraAccessRoute.alertCameraAccessNeeded)
                }
            })
    }

    private func requestAccess() -> Observable<CameraAccessRoute> {
        return self.avFoundation
            .requestAccess.asObservable()
            .map({ status -> CameraAccessRoute in
                guard status else { return CameraAccessRoute.alertCameraAccessNeeded}
                return CameraAccessRoute.showCameraReader
            })
    }

}
