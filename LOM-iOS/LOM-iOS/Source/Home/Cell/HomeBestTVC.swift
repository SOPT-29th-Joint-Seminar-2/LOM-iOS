import UIKit

class HomeBestTVC: UITableViewCell {

    static let identifier = "HomeBestTVC"

    // MARK: TableViewCell @IBOutlets
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookRankLabel: UILabel!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var writerNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(rank: Int, bookName: String, writerName: String, image: String){
        bookRankLabel.text = "\(rank)"
        bookNameLabel.text = bookName
        writerNameLabel.text = writerName
        let url = URL(string: image)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.bookImageView.image = UIImage(data: data!)
            }
        }
    }
    
}
