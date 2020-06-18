//
//  PlayerManagerViewController.swift
//  TVOS-OTT
//
//  Created by Souvik on 18/06/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit
import TvOSAVPlayer

class PlayerManagerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        let videoURL = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
        let avPlayer = TvOSAVPlayer(frame: CGRect(x: view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.size.width, height: self.view.frame.size.height), fileUrl: videoURL ?? Bundle.main.url(forResource: "cloudy", withExtension: "mp4")!)//Bundle.main.url(forResource: "cloudy", withExtension: "mp4")!)
        self.view.addSubview(avPlayer)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
