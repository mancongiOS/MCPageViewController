//
//  MCLocationHelper.swift
//  Alamofire
//
//  Created by MC on 2019/1/28.
//

import UIKit
import MapKit




class MCLocationHelper: NSObject {

    /**
     *  判断是否在中国范围
     *
     *  @param lat 纬度
     *  @param lon 经度
     *
     *  @return bool
     */
    private static func inTheRangeChina(latitude: Double, longitude: Double) -> Bool {
        
        if (longitude < 72.004 || longitude > 137.8347) {
        return false
        }
        if (latitude < 0.8293 || latitude > 55.8271) {
        return false
        }
        return true
    }
    
    
    /**
     *  标准坐标 -> 中国坐标
     *
     *  @param latitude 标准坐标的维度
     *
     *  @param longitude 标准坐标的经度
     *
     *  @return 中国坐标
     */
    public static func transformFromWGSToGCJ(latitude: Double, longitude: Double) -> (latitude:Double,longitude:Double) {
        
        
        var endLatitude : Double = 0
        var endLongitude : Double = 0

        
        // 是否在国内
        if inTheRangeChina(latitude: latitude, longitude: longitude) {
           
            
            let a : Double = 6378245.0
            let ee : Double = 0.00669342162296594323
            let pi : Double = Double.pi

            
            
            var adjustLat = transformLatitude(x: longitude - 105.0, y: latitude - 35.0)
            var adjustLon = transformLongitude(x: longitude - 105.0, y: latitude - 35.0)
            
            let radLat = latitude / 180.0 * pi
            var magic = sin(radLat)
            
            magic = 1 - ee * magic * magic
            let sqrtMagic : Double = sqrt(magic)
            
        
            adjustLat = (adjustLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi);
            adjustLon = (adjustLon * 180.0) / (a / sqrtMagic * cos(radLat) * pi);
            endLatitude = latitude + adjustLat
            endLongitude = longitude + adjustLon
        } else {
            endLatitude = latitude
            endLongitude = longitude
        }
        return (endLatitude,endLongitude)
    }
    
    
    
    /**
     *  中国坐标 -> 标准坐标
     *
     *  @param latitude 标准坐标的维度
     *
     *  @param longitude 标准坐标的经度
     *
     *  @return 中国坐标
     */
    public static func transformFromGCJToWGS(latitude: Double, longitude: Double) -> (latitude:Double,longitude:Double) {
        
        let gcLoc     : (latitude: Double, longitude: Double) = (latitude, longitude)
        var wgLoc     : (latitude: Double, longitude: Double) = (latitude, longitude)
        var currGcLoc : (latitude: Double, longitude: Double) = (0,0)
        var dLoc      : (latitude: Double, longitude: Double) = (0,0)

        
        
        while true {
            currGcLoc = transformFromWGSToGCJ(latitude: latitude, longitude: longitude)
            
            dLoc.latitude = gcLoc.latitude - currGcLoc.latitude;
            dLoc.longitude = gcLoc.longitude - currGcLoc.longitude;
            if (fabs(dLoc.latitude) < 1e-7 && fabs(dLoc.longitude) < 1e-7) {  // 1e-7 ~ centimeter level accuracy
                // Result of experiment:
                //   Most of the time 2 iterations would be enough for an 1e-8 accuracy (milimeter level).
                //
                return wgLoc;
            }
            wgLoc.latitude += dLoc.latitude;
            wgLoc.longitude += dLoc.longitude
        }
        
        return wgLoc
    }
    
    

    /**
     * GCJ-02 to BD-09 (标准坐标系 -> 百度坐标系)
     *
     *  @param latitude 标准坐标的维度
     *
     *  @param longitude 标准坐标的经度
     *
     *  @return 百度坐标
     */
    public static func transformFromGCJToBD(latitude: Double, longitude: Double) -> (latitude:Double,longitude:Double) {
        return (latitude + 0.006, longitude + 0.0065)
    }
    
    
    /**
     * BD-09 to GCJ-02 (百度坐标系 -> 标准坐标系)
     *
     *  @param latitude 百度坐标的维度
     *
     *  @param longitude 百度坐标的经度
     *
     *  @return 标准坐标
     */
    public static func transformFromBDToGCJ(latitude: Double, longitude: Double) -> (latitude:Double,longitude:Double) {
        return (latitude - 0.006, longitude - 0.0065)
    }

    
    
    
    
    private static func transformLatitude(x:Double, y:Double) -> Double {
        let pi : Double = Double.pi

        var lat: Double = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(x > 0 ? x:-x);
        lat += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0;
        lat += (20.0 * sin(y * pi) + 40.0 * sin(y / 3.0 * pi)) * 2.0 / 3.0;
        lat += (160.0 * sin(y / 12.0 * pi) + 320 * sin(y * pi / 30.0)) * 2.0 / 3.0;
        return lat
    }
    
    private static func transformLongitude(x:Double, y:Double) -> Double {
        let pi : Double = Double.pi

        var lon : Double = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(x > 0 ? x:-x);
        lon += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0;
        lon += (20.0 * sin(x * pi) + 40.0 * sin(x / 3.0 * pi)) * 2.0 / 3.0;
        lon += (150.0 * sin(x / 12.0 * pi) + 300.0 * sin(x / 30.0 * pi)) * 2.0 / 3.0;
        return lon;
    }
}
