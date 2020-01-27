//
// Created by Jan Kase on 27/01/2020.
// Copyright (c) 2020 Jan Kaše. All rights reserved.
//

import UIKit

extension UINavigationController {
  open override var shouldAutorotate: Bool {
    true
  }
  open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    topViewController?.supportedInterfaceOrientations ?? .allButUpsideDown
  }
  open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
    topViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
  }
}
