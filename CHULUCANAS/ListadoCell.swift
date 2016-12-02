//
//  ListadoCell.swift
//  CHULUCANAS
//
//  Created by ucweb on 29/11/16.
//  Copyright © 2016 sheylavc. All rights reserved.
//

import UIKit

class ListadoCell: UITableViewCell {

    
    @IBOutlet weak var imgAlerta: UIImageView!
    @IBOutlet weak var nombreAlerta: UILabel!
    @IBOutlet weak var tipoAlerta: UILabel!
    @IBOutlet weak var celularAlerta: UILabel!
    @IBOutlet weak var horaAlerta: UILabel!
    @IBOutlet weak var inicialAlerta: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
