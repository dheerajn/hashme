//
//  PredictionsViewController.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit
import CoreML

//https://github.com/ytakzk/CoreML-samples - help taken from this.
//TODO: try putting different models and compare the results of the prediction and combine everything.

class PredictionsViewController: BaseViewController, LoadingScreenPresentable {
    
    let imagePicker = UIImagePickerController()
    var viewModel: PredictionsViewConfigurable? {
        didSet {
            
        }
    }
    var flowDelegate: HashTagFlowDelegate?
    @IBOutlet weak var cameraButton: CustomButton!
    @IBOutlet weak var photoLibraryButton: CustomButton!
    @IBOutlet weak var predictButton: CustomButton!
    @IBOutlet weak var imageToPredict: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel == nil {
            viewModel = PredictionsViewModel(flowDelegate: self.flowDelegate)
        }
        setupUserInterface()
    }
    
    func setupUserInterface() {
        self.title = viewModel?.screenTitle
        self.cameraButton.setTitle(viewModel?.cameraButtonTitle, for: UIControlState.normal)
        self.photoLibraryButton.setTitle(viewModel?.photoLibraryButtonTitle, for: .normal)
        self.predictButton.setTitle(viewModel?.predictButtonTitle, for: .normal)
    }
    
    @IBAction func cameraButtonTapped(_ sender: CustomButton) {
        openCameraOrPhotoLibrary(sourceType: .camera)
    }
    
    @IBAction func photoLibraryTapped(_ sender: CustomButton) {
        openCameraOrPhotoLibrary(sourceType: .photoLibrary)
    }
    
    @IBAction func predictButtonTapped(_ sender: CustomButton) {
        guard let image = imageToPredict.image, let ref = image.buffer else {
            return
        }
        self.viewModel?.predictImage(ref: ref)
    }
    
    func openCameraOrPhotoLibrary(sourceType: UIImagePickerControllerSourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            let dismissAction: CustomAlertAction = (title: "Ok", style: UIAlertActionStyle.destructive, handler: nil)
            CustomAlertController().displayAlertWithTitle("Huh, looks like we cant open \(sourceType).",
                message: "Sorry, please try again later. Something went wrong.",
                preferredStyle: .alert,
                andActions: [dismissAction],
                onViewController: self)
            return
        }
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension PredictionsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage,
            let resized = image.resize(size: CGSize(width: 224, height: 224)) else {
                return
        }
        self.imageToPredict.image = resized
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
}