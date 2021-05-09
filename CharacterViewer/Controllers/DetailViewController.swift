//  Created by ayu on 05/08/21.

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak private var imageView: UIImageView!
    var viewModel: ViewModelable?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let vm = viewModel as? CharacterViewModel {
            configureDetailView(vm)
        }
    }
    
    private func configureDetailView(_ vm: ViewModelable) {
        self.title = vm.getTitle()
        self.descriptionText.text = vm.getDescription()
        let image = UIImage(named: "Placeholder")
        imageView.image = image
        
        if let imageUrl = vm.getImageUrl(), let url = URL(string: imageUrl) {
            self.imageView.downloadImage(from: url)
        }
    }    
}
