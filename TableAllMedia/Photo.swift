//
//  Photo.swift
//  TableAllMedia
//
//  Created by Zhanna Fursova on 1/19/15.
//  Copyright (c) 2015 John Doe. All rights reserved.
//

import UIKit

class Photo: UIView {


	init(viewController: PhotoController) {
		// Initialization code
		super.init(frame: CGRectZero);
		backgroundColor = UIColor.blackColor();
		

		let button: UIButton = UIButton.buttonWithType(UIButtonType.System) as UIButton;
		button.titleLabel!.font = UIFont.systemFontOfSize(UIFont.buttonFontSize());
		let title: String = "  Take a photo  ";
		button.bounds.size = title.sizeWithAttributes([NSFontAttributeName: button.titleLabel!.font]);
		button.bounds.size.height *= 2;	//Looks better if we double the height.

		button.frame.origin = CGPointMake(80, 200)
		
		button.backgroundColor = UIColor.blackColor();

		button.layer.borderWidth = 0.5;	//0.5 pairs of pixels = 1 pixel
		button.layer.borderColor = UIColor.whiteColor().CGColor;
		button.setTitle(title, forState: UIControlState.Normal);

		button.addTarget(viewController,
			action: "touchUpInside:",
			forControlEvents: UIControlEvents.TouchUpInside);

		addSubview(button);

	
	}

	//Never called.
	required init(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder);
	}

	/*
	// Only override drawRect: if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func drawRect(rect: CGRect) {
		// Drawing code
	}
	*/

}