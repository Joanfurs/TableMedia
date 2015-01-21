//
//  TableViewController.swift
//  TableAllMedia
//
//  Created by Zhanna Fursova on 1/19/15.
//  Copyright (c) 2015 John Doe. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

	let cellReuseIdentifier: String = "section";
	
	let headers: [String] = [	//An array of five Strings.
		"Create a:",
		"2"
	];

	let functions: [[String]] = [
	
		[
		"Photo",
		"Video"],
		
		[
		"1",
		"2"]

		
	];
	
	//Called from application delegate.
	
	/*init(style: UITableViewStyle) {
		super.init(style: style);
		if navigationItem.backBarButtonItem != nil {
			navigationItem.backBarButtonItem!.title = "Back";
		}
	}
	*/
	
	override init(style: UITableViewStyle) {
		super.init(style: style);
		if navigationItem.backBarButtonItem != nil {
			navigationItem.backBarButtonItem!.title = "Back";
		}
	}


	//Called from the above method.

	override init(nibName: String?, bundle: NSBundle?) {
		super.init(nibName: nibName, bundle: bundle);
	}
	
	required init(coder aDecoder: NSCoder) {
		super.init(nibName: nil, bundle: nil);
	}

	override func viewDidLoad() {
		super.viewDidLoad();
		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier);

		//Default values for some of the properties of class UIScrollView.
		tableView.bounces = true;
		tableView.scrollsToTop = true;	//when user taps the status bar
		tableView.decelerationRate = UIScrollViewDecelerationRateNormal; //friction

		// Uncomment the following line to preserve selection between presentations
		// clearsSelectionOnViewWillAppear = false;

		// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		// navigationItem.rightBarButtonItem = editButtonItem();
	}

	// MARK: - Table view data source

	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		// Return the number of sections.
		return functions.count;
	}

	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// Return the number of rows in the section.
		assert(0 <= section && section < functions.count);
		return functions[section].count;	}

	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		assert(0 <= indexPath.section && indexPath.section < functions.count
			&& 0 <= indexPath.row && indexPath.row < functions[indexPath.section].count);

		let cell: UITableViewCell =
			tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as UITableViewCell

		// Configure the cell...
		cell.textLabel!.text = functions[indexPath.section][indexPath.row];
		
			if cell.textLabel!.text == "Photo" {
				cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator;
			} else if cell.textLabel!.text == "Video" {
				cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator;
			} else {
				cell.accessoryType = UITableViewCellAccessoryType.None;
			}
		
		return cell;
	}
	
	override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		assert(0 <= section && section < headers.count);
		return headers[section];
	}

	override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		let cell: UITableViewCell? = tableView.cellForRowAtIndexPath(indexPath);
	/*	if cell != nil {
			if cell!.accessoryType == UITableViewCellAccessoryType.None {
				cell!.accessoryType = UITableViewCellAccessoryType.Checkmark;
			} else {
				cell!.accessoryType = UITableViewCellAccessoryType.None;
			}
		}
	*/
	
		if cell == nil {
			return;
		}

	let ip0: NSIndexPath = NSIndexPath(forRow: 0, inSection: 0);
	let ip1: NSIndexPath = NSIndexPath(forRow: 1, inSection: 0);
	if indexPath.compare(ip0) == NSComparisonResult.OrderedSame {
		
		//if indexPath.section == 0 && indexPath.row == 0 {
		
			let secondController: PhotoController =
				PhotoController(title: "Photo");
			navigationController!.pushViewController(secondController, animated: true);
			
			
		} else /*if indexPath.section == 0 && indexPath.row == 1*/if indexPath.compare(ip1) == NSComparisonResult.OrderedSame {
		
			let thirdController: VideoController =
				VideoController(title: "Video");
			navigationController!.pushViewController(thirdController, animated: true);
			
			
		} else	{
			return;
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	/*
	// Override to support conditional editing of the table view.
	override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		// Return false if you do not want the specified item to be editable.
		return true;
	}
	*/

	/*
	// Override to support editing the table view.
	override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
		if editingStyle == .Delete {
			// Delete the row from the data source
			tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade);
		} else if editingStyle == .Insert {
			// Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
		}
	}
	*/

	/*
	// Override to support rearranging the table view.
	override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

	}
	*/

	/*
	// Override to support conditional rearranging of the table view.
	override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
		// Return false if you do not want the item to be re-orderable.
		return true;
	}
	*/

	/*
	// MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		// Get the new view controller using [segue destinationViewController].
		// Pass the selected object to the new view controller.
	}
	*/

}