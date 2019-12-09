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
    @IBOutlet weak var photoImageView: UIImageView!

    private var viewModel: CameraAccessDataSource = CameraAccessViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        let cameraAccessObservable = cameraAccessButton.rx.tap.asObservable()

        viewModel
            .transformInput(CameraButtonTaps: cameraAccessObservable)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] route in
                switch route {
                case .showCameraReader:
                    self?.showCameraReader()
                case .alertCameraAccessNeeded:
                    self?.alertCameraAccessNeeded()
                }
                print("route:", route)
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

extension CameraAccessViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private func showCameraReader() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            present(imagePicker, animated: true)

        } else if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            present(imagePicker, animated: true)

        } else {
            self.showAlertView(withTitle: "Camera Access not avilabke", andMessage: "This feature requires Camera Access")
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)

        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        self.photoImageView.image = image
        // print out the image size as a test
        print(image.size)
    }
}
