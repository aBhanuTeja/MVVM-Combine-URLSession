import Foundation
import UIKit

open class ReusableTableViewCell: UITableViewCell {
    
    public class var reuseIdentifier: String {
        return "\(self.self)"
    }
    
    public static func registerWithTableViewNib(_ table: UITableView) {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: self.reuseIdentifier, bundle: bundle)
        table.register(nib, forCellReuseIdentifier: self.reuseIdentifier)
    }
}
