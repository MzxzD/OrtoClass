

import UIKit

class CellHeaderFooterView: UITableViewHeaderFooterView {
    
    let sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        contentView.addSubviews(sectionTitleLabel)
        contentView.backgroundColor = UIColor(red:0.12, green:0.77, blue:1.00, alpha:1.0)
        setupConstraints()
    }
    
    private func setupConstraints(){
        
        let constraints = [
            
            sectionTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            sectionTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            sectionTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            sectionTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
