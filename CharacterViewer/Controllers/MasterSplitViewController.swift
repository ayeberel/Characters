//  Created by ayu on 05/08/21.

import UIKit

class MasterSplitViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}

extension MasterSplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        return .primary
    }
}
