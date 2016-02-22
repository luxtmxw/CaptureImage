//
//  CaptureImageViewController.swift
//  CaptureImage
//
//  Created by luxtmxw on 16/2/21.
//  Copyright © 2016年 luxtmxw. All rights reserved.
//

import UIKit

class CaptureImageViewController: UIViewController, UIScrollViewDelegate {
    
    var img_in = UIImage()
    var clipControl : CGFloat = 0
    var midSize = CGSize()
    var imgView = UIImageView()
    var scroll = UIScrollView()
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBarHidden = false
        navigationController?.navigationBar.translucent = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBarHidden = true
        navigationController?.navigationBar.translucent = false
    }
    
    func setupImageCaptrue(image: UIImage, control: CGFloat) {
        img_in = image
        clipControl = control   
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.setupView()
    }
    
    func setupView() {
        view.backgroundColor = UIColor.blackColor()
        
        
        scroll.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50)
        scroll.minimumZoomScale = 1.0
        scroll.maximumZoomScale = 5.0
        scroll.bouncesZoom = true
//        scroll.userInteractionEnabled = true
        scroll.delegate = self
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        scroll.contentMode = UIViewContentMode.Center
        scroll.scrollEnabled = true
        view.addSubview(scroll)
        
        
        
        imgView.image = img_in
        midSize = CGSizeMake(kScreenWidth, kScreenWidth * clipControl)
        let c = imgView.image?.size
        let imgview_height = (c?.height)! * kScreenWidth / (c?.width)!
        
        imgView.frame = CGRectMake(0, (kScreenHeight - 50 - midSize.height) / 2, kScreenWidth, imgview_height)
        scroll.addSubview(imgView)
        scroll.contentSize = CGSizeMake(kScreenWidth, imgview_height + (kScreenHeight - 50 - midSize.height))
        scroll.clipsToBounds = false
        
        print(midSize.height)
        print(imgview_height)
        
        let lbl_topShow = UILabel()
        view.addSubview(lbl_topShow)
        lbl_topShow.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp_top).offset(0)
            make.left.equalTo(view.snp_left).offset(0)
            make.right.equalTo(view.snp_right).offset(0)
            make.height.equalTo((kScreenHeight - 50 - midSize.height) / 2)
        }

        let lbl_midShow = UILabel()
        lbl_midShow.layer.borderWidth = 1
        lbl_midShow.layer.borderColor = UIColor(white: 1, alpha: 0.6).CGColor
//        lbl_midShow.userInteractionEnabled = true
        view.addSubview(lbl_midShow)
        lbl_midShow.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp_left).offset(0)
            make.right.equalTo(view.snp_right).offset(0)
            make.top.equalTo(lbl_topShow.snp_bottom).offset(0)
            make.height.equalTo(midSize.height)
        }
        
        let lbl_bottomShow = UILabel()
//        lbl_bottomShow.backgroundColor = UIColor.redColor()
        view.addSubview(lbl_bottomShow)
        lbl_bottomShow.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp_left).offset(0)
            make.right.equalTo(view.snp_right).offset(0)
            make.bottom.equalTo(view.snp_bottom).offset(-50)
            make.top.equalTo(lbl_midShow.snp_bottom).offset(0)
        }
        
        let cancelBtn = UIButton()
        cancelBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        cancelBtn.setTitle("取消", forState: .Normal)
        cancelBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        cancelBtn.addTarget(self, action: "cancelAction", forControlEvents: .TouchUpInside)
        view.addSubview(cancelBtn)
        cancelBtn.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp_bottom).offset(-20)
            make.left.equalTo(view.snp_left).offset(0)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        
        let selectedBtn = UIButton()
        selectedBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        selectedBtn.setTitle("选择", forState: .Normal)
        selectedBtn.titleLabel?.font = UIFont.systemFontOfSize(16)
        selectedBtn.addTarget(self, action: "selectedAction", forControlEvents: .TouchUpInside)
        view.addSubview(selectedBtn)
        selectedBtn.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(view.snp_bottom).offset(-20)
            make.right.equalTo(view.snp_right).offset(0)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        
        scroll.setContentOffset(CGPointMake(0, (imgview_height - midSize.height)/2), animated: false)
    }
    
    func cancelAction() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func selectedAction() {
        
        let cg = scroll.contentOffset
        let c = imgView.image?.size
        
        let zoom = imgView.frame.size.width/(c?.width)!
        let rec = CGRectMake(cg.x/zoom, cg.y/zoom, midSize.width/zoom, midSize.height/zoom)
        let imageRef = CGImageCreateWithImageInRect(self.fixOrientation(imgView.image!).CGImage, rec)
        let clipImage = UIImage(CGImage: imageRef!)
        
        let rootVC = RootViewController()
        rootVC.isChoose = true
        rootVC.newImage = clipImage
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    // scroll Delegate
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        if scrollView.zoomScale == 1 {
            let c = imgView.image?.size
            let imgView_height = (c?.height)! * kScreenWidth / (c?.width)!
            scroll.contentSize = CGSizeMake(kScreenWidth, kScreenHeight - 50 - midSize.height + imgView_height)
        }else {
            let s = scroll.contentSize
            let c = imgView.image?.size
            let imgView_height = (c?.height)! * kScreenWidth / (c?.width)!
            scroll.contentSize = CGSizeMake(s.width, s.width/s.width*(imgView_height) + (kScreenHeight - 50 - midSize.height))
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imgView
    }
    
    //修改拍摄照片的水平度不然会旋转90度
    func fixOrientation(aImage: UIImage) -> UIImage {
        if aImage.imageOrientation == UIImageOrientation.Up {
            return aImage;
        }
        
        var transform: CGAffineTransform = CGAffineTransformIdentity
        
        switch aImage.imageOrientation {
        case UIImageOrientation.Down: break
        case UIImageOrientation.DownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
            break
        case UIImageOrientation.Left: break
        case UIImageOrientation.LeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0)
            transform = CGAffineTransformRotate(transform,CGFloat(M_PI_2))
            break
            
        case UIImageOrientation.Right: break
        case UIImageOrientation.RightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -CGFloat(M_PI_2))
            break
        default:
            break
        }
        
        switch aImage.imageOrientation {
        case UIImageOrientation.UpMirrored: break
        case UIImageOrientation.DownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0)
            transform = CGAffineTransformScale(transform, -1, 1);
            break
            
        case UIImageOrientation.LeftMirrored: break
        case UIImageOrientation.RightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0)
            transform = CGAffineTransformScale(transform, -1, 1);
            break
        default:
            break
        }
        let ctx: CGContextRef = CGBitmapContextCreate(nil, Int(aImage.size.width), Int(aImage.size.height), CGImageGetBitsPerComponent(aImage.CGImage), 0, CGImageGetColorSpace(aImage.CGImage),CGImageGetBitmapInfo(aImage.CGImage).rawValue)!
        CGContextConcatCTM(ctx, transform)
        switch (aImage.imageOrientation) {
            case UIImageOrientation.Left: break
            case UIImageOrientation.LeftMirrored: break
            case UIImageOrientation.Right: break
            case UIImageOrientation.RightMirrored:
            // Grr...
                CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
            default:
                CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
        }
        
        // And now we just create a new UIImage from the drawing context
        let cgimg: CGImageRef = CGBitmapContextCreateImage(ctx)!
        let img: UIImage = UIImage(CGImage: cgimg)
        
        return img
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
}
