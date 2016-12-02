//
//  Alerta+CoreDataProperties.swift
//  
//
//  Created by ucweb on 30/11/16.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Alerta {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Alerta> {
        return NSFetchRequest<Alerta>(entityName: "Alerta");
    }

    @NSManaged public var ale_descripcion: String?
    @NSManaged public var ale_fec: String?
    @NSManaged public var ale_id: Int16
    @NSManaged public var ale_latitud: String?
    @NSManaged public var ale_longitud: String?
    @NSManaged public var ale_tipo: String?
    @NSManaged public var usu_ape_mat: String?
    @NSManaged public var usu_ape_pat: String?
    @NSManaged public var usu_celular: String?
    @NSManaged public var usu_correo: String?
    @NSManaged public var usu_dni: String?
    @NSManaged public var usu_id: Int16
    @NSManaged public var usu_nombre: String?
    @NSManaged public var ale_estado: String?

}
