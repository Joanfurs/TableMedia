//
//  PhotoController.swift
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

class PhotoController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
	
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
		
		if find(mediaTypes! as [String], kUTTypeImage) == nil {
			println("\(kUTTypeImage) is not available");
			return;
		}

		imagePickerController.mediaTypes = [kUTTypeImage];
		imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.Photo

		

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
		
		imagePickerController.showsCameraControls = true;
		imagePickerController.allowsEditing = false;
		imagePickerController.delegate = self;
		
	}

	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder);
	}
	
	override func loadView() {
		view = Photo(viewController: self);
	}
	
		override func viewDidLoad() {
		super.viewDidLoad();
		// Do any additional setup after loading the view, typically from a nib.
	}

	func touchUpInside(button: UIButton!) {
		imagePickerController.modalPresentationStyle = UIModalPresentationStyle.FullScreen;
		imagePickerController.modalTransitionStyle = UIModalTransitionStyle.CoverVertical;
		presentViewController(imagePickerController, animated: true, completion: nil);
	}

	func imageWasSavedSuccessfully(image: UIImage,didFinishSavingWithError error: NSError!,context:UnsafeMutablePointer<()>){
		if let theError = error{
			println("An error happened while saving the image = \(theError)")
		} else {
			println("Image was saved successfully")
	}
	}

	func imagePickerController(picker: UIImagePickerController,
		didFinishPickingMediaWithInfo info: [NSObject: AnyObject]) {

		let mediaType: CFString? = info[UIImagePickerControllerMediaType] as CFString?;
		
		if mediaType != nil && mediaType! == kUTTypeImage {

			//Print the image's width and height.
			let metadata: [NSObject: AnyObject]? =
				info[UIImagePickerControllerMediaMetadata] as [NSObject: AnyObject]?;
			
			if metadata != nil {
				//Exchangeable image file format
				let exif: [NSObject: AnyObject]? =
					metadata!["{Exif}"] as [NSObject: AnyObject]?;
				if exif != nil {
					let width: Int? = exif!["PixelXDimension"] as Int?;
					let height: Int? = exif!["PixelYDimension"] as Int?;
					if width != nil && height != nil {
						println("dimensions in pixels = \(width!) × \(height!)");
					}
				}
			}

			//Is there an image to save?
		
			var imageToSave: UIImage!;
			if imagePickerController.allowsEditing{
				imageToSave = info[UIImagePickerControllerEditedImage] as UIImage
			} else {
				imageToSave = info[UIImagePickerControllerOriginalImage] as UIImage
			}

			//Save the image to the Camera Roll album.
		
			if imageToSave == nil {
				println("could not find original image or edited image");
			} else {
				let assetsLibrary: ALAssetsLibrary = ALAssetsLibrary();
				assetsLibrary.writeImageToSavedPhotosAlbum(
					imageToSave!.CGImage,
					metadata: metadata,
					completionBlock: {(url: NSURL!, error: NSError!) in
						println("image written: URL = \(url), error = \(error)");
					}
				);
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
