//
//  RootViewController.swift
//  CaptureImage
//
//  Created by luxtmxw on 16/2/20.
//  Copyright © 2016年 luxtmxw. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var newImage = UIImage()
    var isChoose = false
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.translucent = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.translucent = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        if isChoose == true {
            let imageView = UIImageView()
            imageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenWidth * 180 / 375)
            imageView.image = newImage
            view.addSubview(imageView)
            
        }else {
            let btn = UIButton()
            btn.frame = CGRectMake(0, 0, kScreenWidth, 30)
            btn.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            btn.setTitle("相册", forState: UIControlState.Normal)
            btn.addTarget(self, action: "btnAction", forControlEvents: .TouchUpInside)
            view.addSubview(btn)
            
        }
        
        
        // Do any additional setup after loading the view.
    }

    func btnAction() {
        if UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum) {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .SavedPhotosAlbum
            self.presentViewController(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let captureVC = CaptureImageViewController()
        captureVC.setupImageCaptrue(image, control: 180/375)
        picker.pushViewController(captureVC, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
