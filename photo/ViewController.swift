//
//  ViewController.swift
//  photo
//
//  Created by hahahahahanananana on 2017/06/13.
//  Copyright © 2017年 片岡. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController,AVCapturePhotoCaptureDelegate  {
    
    let captureSession: AVCaptureSession = AVCaptureSession()
    
    var imageOutput: AVCapturePhotoOutput = AVCapturePhotoOutput()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let devices = AVCaptureDeviceDiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: nil, position: .back).devices
        
        let videoInput = try? AVCaptureDeviceInput(device: devices?.first)
        
        captureSession.addInput(videoInput)
        
        captureSession.addOutput(imageOutput)
        
        
        let captureVideoLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        captureVideoLayer.frame = self.view.bounds
        captureVideoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        
        self.view.layer.insertSublayer(captureVideoLayer, at: 0)
        
        
        
        captureSession.startRunning()
    }
    
    @IBAction func cameraStart(_ sender: UIButton) {
        
        let setting = AVCapturePhotoSettings()
        setting.flashMode = .auto
        setting.isAutoStillImageStabilizationEnabled = true
        setting.isHighResolutionPhotoEnabled = false
        imageOutput.capturePhoto(with: setting, delegate: self)
        captureSession.stopRunning()
    }
    
    func capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?) {
        
        if let error = error {
            
            print("ERROR: capture(_ captureOutput: AVCapturePhotoOutput, didFinishProcessingPhotoSampleBuffer photoSampleBuffer: CMSampleBuffer?, previewPhotoSampleBuffer: CMSampleBuffer?, resolvedSettings: AVCaptureResolvedPhotoSettings, bracketSettings: AVCaptureBracketedStillImageSettings?, error: Error?)...\(error.localizedDescription)")
        }
        else {
            
            guard
                let photoSampleBuffer = photoSampleBuffer,
                let photoData = AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer, previewPhotoSampleBuffer: previewPhotoSampleBuffer),
                let image = UIImage(data: photoData) else { return }
            
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageWriteToSavedPhotosAlbum(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    private dynamic func imageWriteToSavedPhotosAlbum(_ image: UIImage!, didFinishSavingWithError error: Error?,  contextInfo: Any?) {
        
        if let error = error {
            
            print("ERROR: imageWriteToSavedPhotosAlbum(_:didFinishSavingWithError:contextInfo) ... \(error)")
        }
        else {
            
            
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
