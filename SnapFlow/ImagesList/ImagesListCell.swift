import UIKit

final class ImagesListCell: UITableViewCell {
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) { super.setHighlighted(false, animated: false) }
    override func setSelected(_ selected: Bool, animated: Bool) { super.setSelected(false, animated: false) }
    
    static let reuseIdentifier = "ImagesListCell"
}
