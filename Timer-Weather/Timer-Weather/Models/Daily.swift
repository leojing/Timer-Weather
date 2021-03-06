//
//	Daily.swift
//
//	Create by Jing Luo on 20/4/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation 
import ObjectMapper


class Daily : NSObject, NSCoding, Mappable{

	var data : [WeatherDetail]?
	var icon : String?
	var summary : String?


	class func newInstance(map: Map) -> Mappable?{
		return Daily()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		data <- map["data"]
		icon <- map["icon"]
		summary <- map["summary"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         data = aDecoder.decodeObject(forKey: "data") as? [WeatherDetail]
         icon = aDecoder.decodeObject(forKey: "icon") as? String
         summary = aDecoder.decodeObject(forKey: "summary") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if data != nil{
			aCoder.encode(data, forKey: "data")
		}
		if icon != nil{
			aCoder.encode(icon, forKey: "icon")
		}
		if summary != nil{
			aCoder.encode(summary, forKey: "summary")
		}

	}

}
