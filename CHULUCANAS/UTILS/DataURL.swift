//
//  DataURL.swift
//  CHULUCANAS
//
//  Created by ucweb on 24/11/16.
//  Copyright © 2016 sheylavc. All rights reserved.
//

import UIKit

class DataURL: NSObject {
    
    struct GlobalVariables {
        
        // ULR BASE
        static var UrlBase : String! = "http://uc-web.mobi/CHULUCANA/"
        
        
        //GOOGLE MAPS KEY
        static var googlemapkey : String! = "AIzaSyDQ68vziolcmL2hIpn1o2sxRpv_dPhHlwY"
        
        
        // Rutas
        static var getUsuario : String! = UrlBase + "get_user_ios.php"
        static var updatePassword : String! = UrlBase + "cambiar_contrasenia_ios.php"
        static var sendConsulta : String! = UrlBase + "enviar_sugerencia_ios.php"
        static var sendAlerta : String! = UrlBase + "create_new_alerta_ios.php"
        static var updateAlerta : String!  = UrlBase + "update_new_alerta_ios.php"
        
        
        static var restorePassword : String! = UrlBase + "enviar_nueva_contrasenia.php"
        static var registerToken : String! = UrlBase + "registrar_token_ios.php"
        
        static var getAlertas : String! = UrlBase + "get_all_alertas.php"
        
        
        
    }
    
}
