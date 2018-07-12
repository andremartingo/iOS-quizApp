import UIKit


extension UITableView {
    func cell(at row:Int) -> UITableViewCell{
        let indexPath = IndexPath(row: row, section: 0)
        return (dataSource?.tableView(self, cellForRowAt: indexPath))!
    }
    
    func title(at row: Int) -> String? {
        return cell(at: row).textLabel?.text
    }
    
    func select(row: Int){
        let indexPath = IndexPath(row: row, section: 0)
        selectRow(at: indexPath, animated: false, scrollPosition: .none)
        delegate?.tableView!(self, didSelectRowAt: indexPath)
    }
    
    func deselect(row: Int){
        let indexPath = IndexPath(row: row, section: 0)
        deselectRow(at: indexPath, animated: false)
        delegate?.tableView!(self, didDeselectRowAt: indexPath)
    }
}

