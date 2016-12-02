//
//  Usuario+CoreDataProperties.swift
//  
//
//  Created by ucweb on 30/11/16.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Usuario {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Usuario> {
        return NSFetchRequest<Usuario>(entityName: "Usuario");
    }

    @NSManaged public var tip_id: Int16
    @NSManaged public var usu_ape_mat: String?
    @NSManaged public var usu_ape_pat: String?
    @NSManaged public var usu_correo: String?
    @NSManaged public var usu_id: Int16
    @NSManaged public var usu_nombre: String?
    @NSManaged public var usu_password: String?
    @NSManaged public var usu_token: String?
    @NSManaged public var token: String?

}
