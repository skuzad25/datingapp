//
//  UpdateProfileModel.swift
//  Dating
//
//  Created by Iram Khan on 06/10/23.
//

import Foundation

struct UpdateProfileModel : Codable {
    let id,role,gender,is_profile_complete : Int?
    let name,email,dob,password,location,latitude,longitude,height,weight,interest,about_us,device_type,device_token,created_at,updated_at : String?
}
typealias updateProfileModel = UpdateProfileModel
