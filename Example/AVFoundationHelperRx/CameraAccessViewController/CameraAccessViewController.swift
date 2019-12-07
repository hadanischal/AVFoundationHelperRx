//
//  CameraAccessViewController.swift
//  AVFoundationHelperRx_Example
//
//  Created by Nischal Hada on 6/12/19.
//  Copyright © 2019 Nischal Hada. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CameraAccessViewController: UIViewController {

    @IBOutlet weak var cameraAccessButton: UIButton!
    private var viewModel: CameraAccessDataSource = CameraAccessViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        let cameraAccessObservable = cameraAccessButton.rx.tap.asObservable()

        viewModel
            .transformInput(linkButtonTaps: cameraAccessObservable)
            .subscribe(onNext: { [weak self] loginRoute in
                if loginRoute == .alertCameraAccessNeeded {
                    self?.alertCameraAccessNeeded()
                }
                print("loginRoute:", loginRoute)
            }, onError: { error in
                print("error:", error)
            }).disposed(by: disposeBag)
    }

    private func alertCameraAccessNeeded() {
        let appName = Bundle.main.displayName ?? "This app"

        let alert = UIAlertController(title: "This feature requires Camera Access",
                                      message: "In iPhone settings, tap \(appName) and turn on Camera access",
            preferredStyle: UIAlertController.Style.alert)

        let actionSettings = UIAlertAction(title: "Settings", style: .default, handler: { (_) -> Void in
            guard let settingsAppURL = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(settingsAppURL)
        })

        let actionCancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (_) -> Void in
        })

        alert.addAction(actionSettings)
        alert.addAction(actionCancel)

        self.present(alert, animated: true, completion: nil)
    }

}
