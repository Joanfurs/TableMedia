//
//  VideoController.swift
//  TableAllMedia
//
//  Created by Zhanna Fursova on 1/19/15.
//  Copyright (c) 2015 John Doe. All rights reserved.
//

import UIKit;
import MobileCoreServices;	//for kUTTypeImage
import AssetsLibrary;		//for writeImageToSavedPhotosAlbum(_:metadata:completionBlock:)
import AVFoundation
import CoreMedia


class VideoController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

	let imagePickerController: UIImagePickerController = UIImagePickerController();
	
	init(title: String) {
		super.init(nibName: nil, bundle: nil);
		self.title = title;	//self.title is the property, title is the parameter
		navigationItem.prompt = "Welcome to \(title)!";
		
		if !UIImagePickerController.isSourceTypeAvailable(.Camera) {
			println("Camera not available");
			return;
		}
		
		if !UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
			println("Photo Library not available");
			return;
		}
		
		if !UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum) {
			println("Camera roll not available");
			return;
		}

		imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera;

		let mediaTypes: [AnyObject]? =
			UIImagePickerController.availableMediaTypesForSourceType(.Camera);
		
		
		if find(mediaTypes! as [String], kUTTypeMovie) == nil {
			println("\(kUTTypeMovie) is not available");
			return;
		}

		imagePickerController.mediaTypes = [kUTTypeMovie];
		imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.Video;

		if !UIImagePickerController.isCameraDeviceAvailable(.Front) {
			println("front camera is not available");
			return;
		}
		
		if !UIImagePickerController.isCameraDeviceAvailable(.Rear) {
			println("rear camera is not available");
			return;
		}
		
		if UIImagePickerController.isFlashAvailableForCameraDevice(.Front) {
			imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashMode.Auto;
		}
		
		if UIImagePickerController.isFlashAvailableForCameraDevice(.Rear) {
			imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashMode.Auto;
		}
		
		imagePickerController.videoMaximumDuration = 10.0;
		imagePickerController.showsCameraControls = true;
		imagePickerController.allowsEditing = false;
		imagePickerController.delegate = self;

	}


	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder);

	}
	
	override func loadView() {
		view = Video(viewController: self);
	}

	override func viewDidLoad() {
		super.viewDidLoad();
		// Do any additional setup after loading the view, typically from a nib.
	}

	//This method is called when the user presses the "Camera" button in the big white View.

	func touchUpInside(button: UIButton!) {
		imagePickerController.modalPresentationStyle = UIModalPresentationStyle.FullScreen;
		imagePickerController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical;
		presentViewController(imagePickerController, animated: true, completion: nil);
	}
	
	func imagePickerController(picker: UIImagePickerController,
		didFinishPickingMediaWithInfo info: [NSObject: AnyObject]) {

		let mediaType: CFString? = info[UIImagePickerControllerMediaType] as CFString?;
		if mediaType != nil && mediaType! == kUTTypeMovie {

			//Get the URL that leads to the video file.
			let url: NSURL? = info[UIImagePickerControllerMediaURL] as NSURL?
			if url != nil {
				println("url! = \(url!)");
				println("url!.relativePath! = \(url!.relativePath!)");

				//Save the video file in the Camera Roll.
				if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url!.relativePath!) {
					UISaveVideoAtPathToSavedPhotosAlbum(url!.relativePath!, nil, nil, nil);
				} else {
					println("Cannot save video to Camera Roll.");
				}
			}
		}

		dismissViewControllerAnimated(true, completion: nil);
	}

	func imagePickerControllerDidCancel(picker: UIImagePickerController) {
		println("didCancel");
		dismissViewControllerAnimated(true, completion: nil);
	}
	
		override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

}
